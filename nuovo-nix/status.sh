#!/bin/bash
cd ~/nuovo-nix

echo "📊 STATO INFRASTRUTTURA - PORTALE COMMESSE"
echo "=========================================="
echo "Data: $(date)"
echo ""

# Colori per output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funzioni di utility
print_status() {
    if [ "$1" = "true" ]; then
        echo -e "  ${GREEN}✅ $2${NC}"
    else
        echo -e "  ${RED}❌ $2${NC}"
    fi
}

print_warning() {
    echo -e "  ${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "  ${BLUE}📋 $1${NC}"
}

# ========== 1. SERVIZI ==========
echo "1. 🚀 SERVIZI"
echo "------------"

# MariaDB
MYSQL_RUNNING=$(ps aux | grep -q "[m]ysqld.*mysql-data" && echo "true" || echo "false")
print_status "$MYSQL_RUNNING" "MariaDB"

# Tomcat
TOMCAT_RUNNING=$(ps aux | grep -q "[t]omcat" && echo "true" || echo "false")
print_status "$TOMCAT_RUNNING" "Tomcat"

# Apache
APACHE_RUNNING=$(ps aux | grep -q "[h]ttpd.*apache" && echo "true" || echo "false")
print_status "$APACHE_RUNNING" "Apache"

echo ""

# ========== 2. PORTE ==========
echo "2. 🔌 PORTE IN ASCOLTO"
echo "---------------------"
PORTS=""

# Porta 3306 (MariaDB)
if netstat -tln 2>/dev/null | grep -q ":3306"; then
    PORTS="${PORTS}3306 (MariaDB) "
fi

# Porta 8080 (Tomcat)
if netstat -tln 2>/dev/null | grep -q ":8080"; then
    PORTS="${PORTS}8080 (Tomcat) "
fi

# Porta 9090 (Apache)
if netstat -tln 2>/dev/null | grep -q ":9090"; then
    PORTS="${PORTS}9090 (Apache) "
fi

if [ -n "$PORTS" ]; then
    echo -e "  ${GREEN}✅ Porte attive: $PORTS${NC}"
else
    echo -e "  ${RED}❌ Nessuna porta in ascolto${NC}"
fi

echo ""

# ========== 3. APPLICAZIONE ==========
echo "3. 📱 APPLICAZIONE"
echo "-----------------"

APP_NAME="commesse-0.0.1-SNAPSHOT"

# Spring Boot via Tomcat (diretto)
echo -n "  Spring Boot (Tomcat): "
HTTP_TOMCAT=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "http://localhost:8080/$APP_NAME/" 2>/dev/null || echo "000")
case $HTTP_TOMCAT in
    200) echo -e "${GREEN}✅ 200 OK${NC}" ;;
    404) echo -e "${YELLOW}⚠️  404 Not Found (applicazione risponde)${NC}" ;;
    000) echo -e "${RED}❌ Non risponde${NC}" ;;
    503) echo -e "${RED}❌ 503 Service Unavailable${NC}" ;;
    *)   echo -e "${YELLOW}⚠️  HTTP $HTTP_TOMCAT${NC}" ;;
esac

# Spring Boot via Apache (proxy)
echo -n "  Spring Boot (Apache): "
HTTP_APACHE=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "http://localhost:9090/$APP_NAME/" 2>/dev/null || echo "000")
case $HTTP_APACHE in
    200) echo -e "${GREEN}✅ 200 OK${NC}" ;;
    404) echo -e "${YELLOW}⚠️  404 Not Found (proxy funziona)${NC}" ;;
    503) echo -e "${RED}❌ 503 Service Unavailable (Tomcat down?)${NC}" ;;
    000) echo -e "${RED}❌ Non risponde${NC}" ;;
    *)   echo -e "${YELLOW}⚠️  HTTP $HTTP_APACHE${NC}" ;;
esac

# Frontend Angular
echo -n "  Frontend Angular: "
HTTP_FRONTEND=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "http://localhost:9090/" 2>/dev/null || echo "000")
if [ "$HTTP_FRONTEND" = "200" ]; then
    echo -e "${GREEN}✅ 200 OK${NC}"
else
    echo -e "${RED}❌ HTTP $HTTP_FRONTEND${NC}"
fi

echo ""

# ========== 4. DATABASE ==========
echo "4. 🗄️  DATABASE"
echo "-------------"

if mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse -e "SELECT 1" 2>/dev/null >/dev/null; then
    # Connessione OK
    TABLES=$(mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse -e "USE gestione_commesse; SELECT COUNT(*) as tables FROM information_schema.tables WHERE table_schema = 'gestione_commesse';" 2>/dev/null | tail -1 | tr -d '\n')
    
    if [ -n "$TABLES" ] && [ "$TABLES" -gt 0 ]; then
        echo -e "  ${GREEN}✅ Connesso - $TABLES tabelle${NC}"
        
        # Mostra alcune tabelle di esempio
        SAMPLE_TABLES=$(mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse -e "USE gestione_commesse; SHOW TABLES LIMIT 5;" 2>/dev/null | tail -5 | tr '\n' ', ' | sed 's/, $//')
        if [ -n "$SAMPLE_TABLES" ]; then
            print_info "Tabelle: $SAMPLE_TABLES..."
        fi
    else
        echo -e "  ${YELLOW}⚠️  Connesso ma database vuoto o non accessibile${NC}"
    fi
else
    echo -e "  ${RED}❌ Non connesso${NC}"
fi

echo ""

# ========== 5. FILE APPLICAZIONE ==========
echo "5. 📁 FILE APPLICAZIONE"
echo "----------------------"

# WAR file
if [ -f "tomcat10/webapps/$APP_NAME.war" ]; then
    WAR_SIZE=$(ls -lh "tomcat10/webapps/$APP_NAME.war" | awk '{print $5}')
    WAR_TIME=$(stat -c %y "tomcat10/webapps/$APP_NAME.war" | cut -d' ' -f1)
    echo -e "  ${GREEN}✅ WAR: $WAR_SIZE (mod: $WAR_TIME)${NC}"
else
    echo -e "  ${RED}❌ WAR: Non trovato${NC}"
fi

# Directory applicazione deployata
if [ -d "tomcat10/webapps/$APP_NAME" ]; then
    APP_FILES=$(find "tomcat10/webapps/$APP_NAME" -type f | wc -l)
    echo -e "  ${GREEN}✅ App deployata: $APP_FILES file${NC}"
fi

# Frontend
if [ -d "tomcat10/webapps/commesse" ]; then
    FRONTEND_FILES=$(find tomcat10/webapps/commesse -type f | wc -l)
    echo -e "  ${GREEN}✅ Frontend: $FRONTEND_FILES file${NC}"
fi

# SQL file
if [ -f "db/gestione_commesse.sql" ]; then
    SQL_SIZE=$(ls -lh "db/gestione_commesse.sql" | awk '{print $5}')
    echo -e "  ${GREEN}✅ SQL: $SQL_SIZE${NC}"
fi

# File per prossimo deploy
if [ -f "deploy-packages/latest/commesse.war" ]; then
    DEPLOY_WAR_SIZE=$(ls -lh "deploy-packages/latest/commesse.war" 2>/dev/null | awk '{print $5}' || echo "?")
    print_info "Prossimo deploy: WAR $DEPLOY_WAR_SIZE pronto"
fi

echo ""

# ========== 6. LOG ==========
echo "6. 📝 LOG"
echo "--------"

# Dimensione log Tomcat
if [ -f "tomcat10/logs/catalina.out" ]; then
    LOG_SIZE=$(ls -lh "tomcat10/logs/catalina.out" | awk '{print $5}')
    LOG_LINES=$(wc -l < "tomcat10/logs/catalina.out" 2>/dev/null || echo "0")
    print_info "Tomcat log: $LOG_SIZE ($LOG_LINES righe)"
fi

# Dimensione log Apache
if [ -f "apache/logs/error.log" ]; then
    APACHE_LOG_SIZE=$(ls -lh "apache/logs/error.log" | awk '{print $5}')
    print_info "Apache log: $APACHE_LOG_SIZE"
fi

# Dimensione log DB
if [ -f "mysql-data/mysql-error.log" ]; then
    DB_LOG_SIZE=$(ls -lh "mysql-data/mysql-error.log" | awk '{print $5}')
    print_info "Database log: $DB_LOG_SIZE"
fi

echo ""

# ========== 7. URL E COMANDI ==========
echo "7. 🌐 ACCESSO"
echo "-----------"
echo -e "  ${BLUE}🔗 Frontend:  http://localhost:9090/${NC}"
echo -e "  ${BLUE}🔗 API:       http://localhost:9090/$APP_NAME/${NC}"
echo -e "  ${BLUE}🔗 Tomcat:    http://localhost:8080/$APP_NAME/${NC}"
echo ""
echo -e "  ${BLUE}💻 Database:  mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse${NC}"

echo ""

# ========== 8. COMANDI RAPIDI ==========
echo "8. 🛠️  COMANDI RAPIDI"
echo "-------------------"
echo -e "  ${YELLOW}./deploy-update.sh           # Deploy aggiornamenti${NC}"
echo -e "  ${YELLOW}./quick-update.sh file.war sql # Deploy rapido${NC}"
echo -e "  ${YELLOW}tail -f tomcat10/logs/catalina.out  # Log Spring Boot${NC}"
echo -e "  ${YELLOW}tail -f apache/logs/error.log       # Log Apache${NC}"

echo ""
echo "=========================================="
echo "🔍 Per problemi: controlla i log sopra indicati"

# Suggerimento in base allo stato
if [ "$MYSQL_RUNNING" = "false" ] || [ "$TOMCAT_RUNNING" = "false" ] || [ "$APACHE_RUNNING" = "false" ]; then
    echo ""
    echo -e "${YELLOW}💡 SUGGERIMENTO: Alcuni servizi non sono attivi.${NC}"
    echo -e "${YELLOW}   Esegui: ./deploy-update.sh per avviare tutto${NC}"
fi

if [ "$HTTP_APACHE" = "503" ]; then
    echo ""
    echo -e "${YELLOW}💡 SUGGERIMENTO: Apache proxy dà 503.${NC}"
    echo -e "${YELLOW}   Tomcat potrebbe non rispondere. Controlla: tail -f tomcat10/logs/catalina.out${NC}"
fi
