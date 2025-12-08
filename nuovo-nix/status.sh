#!/bin/bash
cd ~/nuovo-nix

echo "📊 STATO COMPLETO INFRASTRUTTURA COMMESSE"
echo "========================================="
echo ""

# 1. SERVIZI
echo "1. 🚀 SERVIZI:"
if ps aux | grep -q "[m]ysqld.*mysql-data"; then 
    echo "   ✅ MariaDB      - In esecuzione"
else
    echo "   ❌ MariaDB      - Fermo"
fi

if ps aux | grep -q "[t]omcat"; then
    echo "   ✅ Tomcat       - In esecuzione"
else
    echo "   ❌ Tomcat       - Fermo"
fi

if ps aux | grep -q "[h]ttpd.*apache"; then
    echo "   ✅ Apache       - In esecuzione"
else
    echo "   ❌ Apache       - Fermo"
fi

# 2. PORTE
echo ""
echo "2. 🔌 PORTE IN ASCOLTO:"
netstat -tln 2>/dev/null | grep -E ":(3306|8080|9090)" | sort | while read line; do
    echo "   $line"
done

# 3. APPLICAZIONE
echo ""
echo "3. 📱 APPLICAZIONE:"
APP_NAME="commesse-0.0.1-SNAPSHOT"

echo -n "   Spring Boot (Tomcat diretto): "
HTTP_CODE_TOMCAT=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8080/$APP_NAME/" 2>/dev/null || echo "000")
case $HTTP_CODE_TOMCAT in
    200) echo "✅ 200 OK" ;;
    404) echo "⚠️  404 Not Found (ma risponde)" ;;
    000) echo "❌ Non risponde" ;;
    *)   echo "⚠️  HTTP $HTTP_CODE_TOMCAT" ;;
esac

echo -n "   Spring Boot (Apache proxy): "
HTTP_CODE_APACHE=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:9090/$APP_NAME/" 2>/dev/null || echo "000")
case $HTTP_CODE_APACHE in
    200) echo "✅ 200 OK" ;;
    404) echo "⚠️  404 Not Found (ma risponde)" ;;
    503) echo "❌ 503 Service Unavailable (Tomcat down?)" ;;
    000) echo "❌ Non risponde" ;;
    *)   echo "⚠️  HTTP $HTTP_CODE_APACHE" ;;
esac

echo -n "   Frontend Angular: "
HTTP_CODE_FRONTEND=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:9090/" 2>/dev/null || echo "000")
if [ "$HTTP_CODE_FRONTEND" = "200" ]; then
    echo "✅ 200 OK"
else
    echo "❌ HTTP $HTTP_CODE_FRONTEND"
fi

# 4. DATABASE
echo ""
echo "4. 🗄️  DATABASE:"
if mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse -e "SELECT 1" 2>/dev/null >/dev/null; then
    TABLES=$(mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse -e "USE gestione_commesse; SELECT COUNT(*) as tables FROM information_schema.tables WHERE table_schema = 'gestione_commesse';" 2>/dev/null | tail -1)
    echo "   ✅ Connesso - $TABLES tabelle"
else
    echo "   ❌ Non connesso"
fi

# 5. FILE
echo ""
echo "5. 📁 FILE APPLICAZIONE:"
if [ -f "tomcat10/webapps/$APP_NAME.war" ]; then
    WAR_SIZE=$(ls -lh "tomcat10/webapps/$APP_NAME.war" | awk '{print $5}')
    echo "   ✅ WAR: $WAR_SIZE"
else
    echo "   ❌ WAR: Non trovato"
fi

if [ -d "tomcat10/webapps/commesse" ]; then
    FRONTEND_FILES=$(find tomcat10/webapps/commesse -type f | wc -l)
    echo "   ✅ Frontend: $FRONTEND_FILES file"
else
    echo "   ❌ Frontend: Directory non trovata"
fi

if [ -f "db/gestione_commesse.sql" ]; then
    SQL_SIZE=$(ls -lh "db/gestione_commesse.sql" | awk '{print $5}')
    echo "   ✅ SQL: $SQL_SIZE"
else
    echo "   ❌ SQL: Non trovato"
fi

echo ""
echo "🌐 URL:"
echo "   http://localhost:9090/                    # Frontend"
echo "   http://localhost:9090/$APP_NAME/         # API"
echo "   http://localhost:8080/$APP_NAME/         # Tomcat diretto"
echo ""
echo "🔧 COMANDI:"
echo "   ./start-all.sh       # Avvia tutto"
echo "   ./stop-all.sh        # Ferma tutto"
echo "   ./deploy-update.sh   # Deploy aggiornamenti"
echo "   ./quick-update.sh file.war file.sql  # Deploy rapido"
