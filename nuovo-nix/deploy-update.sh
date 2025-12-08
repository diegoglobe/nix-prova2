#!/bin/bash
# DEPLOY-UPDATE.sh
# Script autonomo per sviluppo - Aggiorna l'applicazione con nuovi file

cd ~/nuovo-nix

echo "🤖 DEPLOY AUTONOMO - PORTALE COMMESSE"
echo "======================================"
echo ""

# Directory sorgente
SOURCE_DIR="deploy-packages/latest"
BACKUP_DIR="deploy-packages/backup/$(date +%Y%m%d_%H%M%S)"
APP_NAME="commesse-0.0.1-SNAPSHOT"

# Crea backup
mkdir -p "$BACKUP_DIR"

# 1. VERIFICA FILE DISPONIBILI
echo "📦 FILE DISPONIBILI PER L'AGGIORNAMENTO:"
WAR_UPDATED=false
SQL_UPDATED=false
FRONTEND_UPDATED=false

if [ -f "$SOURCE_DIR/commesse.war" ]; then
    echo "   ✅ WAR trovato: $(ls -lh "$SOURCE_DIR/commesse.war")"
    WAR_UPDATED=true
fi

if [ -f "$SOURCE_DIR/gestione_commesse.sql" ]; then
    echo "   ✅ SQL trovato: $(ls -lh "$SOURCE_DIR/gestione_commesse.sql")"
    SQL_UPDATED=true
fi

if [ -d "$SOURCE_DIR/frontend" ] && [ "$(ls -A "$SOURCE_DIR/frontend" 2>/dev/null)" ]; then
    echo "   ✅ Frontend trovato: $(find "$SOURCE_DIR/frontend" -type f | wc -l) file"
    FRONTEND_UPDATED=true
fi

if [ "$WAR_UPDATED" = false ] && [ "$SQL_UPDATED" = false ] && [ "$FRONTEND_UPDATED" = false ]; then
    echo ""
    echo "⚠️  Nessun file di aggiornamento trovato in $SOURCE_DIR/"
    echo "   Per aggiornare, copia i file in:"
    echo "   - $SOURCE_DIR/commesse.war"
    echo "   - $SOURCE_DIR/gestione_commesse.sql"
    echo "   - $SOURCE_DIR/frontend/*"
    exit 1
fi

echo ""
read -p "📋 Procedere con il deploy? (s/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "❌ Deploy annullato"
    exit 0
fi

# 2. FERMA TOMCAT
echo "⏹️  Fermo Tomcat..."
cd tomcat10
./bin/catalina.sh stop 2>/dev/null || true
cd ..
sleep 5

# 3. BACKUP FILE CORRENTI
echo "💾 Backup file correnti..."
if [ -f "tomcat10/webapps/$APP_NAME.war" ]; then
    cp "tomcat10/webapps/$APP_NAME.war" "$BACKUP_DIR/" 2>/dev/null || true
fi
if [ -f "db/gestione_commesse.sql" ]; then
    cp "db/gestione_commesse.sql" "$BACKUP_DIR/" 2>/dev/null || true
fi

# 4. APPLICA AGGIORNAMENTI
echo "🔄 Applico aggiornamenti..."

if [ "$WAR_UPDATED" = true ]; then
    echo "   📦 Aggiorno applicazione WAR..."
    cp "$SOURCE_DIR/commesse.war" "tomcat10/webapps/$APP_NAME.war"
    rm -rf "tomcat10/webapps/$APP_NAME" 2>/dev/null || true
fi

if [ "$SQL_UPDATED" = true ]; then
    echo "   🗄️  Aggiorno database..."
    cp "$SOURCE_DIR/gestione_commesse.sql" "db/gestione_commesse.sql"
    echo "     Import SQL in corso..."
    mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse gestione_commesse < "$SOURCE_DIR/gestione_commesse.sql" 2>/dev/null || \
        echo "     ⚠️  Nota: Potrebbero esserci errori nell'import SQL"
fi

if [ "$FRONTEND_UPDATED" = true ]; then
    echo "   🎨 Aggiorno frontend..."
    rm -rf tomcat10/webapps/commesse 2>/dev/null || true
    cp -r "$SOURCE_DIR/frontend" tomcat10/webapps/commesse
    
    # Aggiorna anche Apache
    rm -rf apache/www/* 2>/dev/null || true
    cp -r "$SOURCE_DIR/frontend"/* apache/www/ 2>/dev/null || true
fi

# 5. RIAVVIA TOMCAT
echo "🚀 Riavvio Tomcat..."
cd tomcat10
export JAVA_OPTS="-Xms512m -Xmx1024m -Djava.awt.headless=true -Dfile.encoding=UTF-8"
./bin/catalina.sh start
cd ..

# 6. VERIFICA
echo ""
echo "⏳ L'applicazione si sta avviando..."
echo "   Attendere 30-45 secondi per l'avvio completo di Spring Boot"
echo ""
echo "📊 VERIFICA AUTOMATICA TRA 40 SECONDI:"
sleep 40

echo ""
echo "=== RISULTATO DEPLOY ==="
echo "✅ DEPLOY COMPLETATO"
echo ""
echo "📋 STATO APPLICAZIONE:"
echo -n "   Tomcat: "
if ps aux | grep -q "[t]omcat"; then echo "✅ In esecuzione"; else echo "❌ Non in esecuzione"; fi

echo -n "   Spring Boot: "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8080/$APP_NAME/" 2>/dev/null || echo "000")
if [[ "$HTTP_CODE" =~ ^(200|404|500)$ ]]; then
    echo "✅ Risponde (HTTP $HTTP_CODE)"
else
    echo "⚠️  Risposta inattesa (HTTP $HTTP_CODE)"
fi

echo -n "   Database: "
if mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse -e "SELECT 1" 2>/dev/null; then
    TABLES=$(mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse -e "USE gestione_commesse; SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'gestione_commesse';" 2>/dev/null | tail -1)
    echo "✅ Connesso ($TABLES tabelle)"
else
    echo "⚠️  Non connesso"
fi

echo ""
echo "🌐 URL ACCESSIBILI:"
echo "   Frontend Angular:  http://localhost:9090/"
echo "   API Spring Boot:   http://localhost:9090/$APP_NAME/"
echo "   Tomcat Manager:    http://localhost:8080/manager/html"
echo ""
echo "🔧 COMANDI UTILI:"
echo "   tail -f tomcat10/logs/catalina.out              # Log Spring Boot"
echo "   mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse  # Connetti al DB"
echo "   ./status.sh                                     # Verifica stato"
echo ""
echo "📁 BACKUP CREATO IN: $BACKUP_DIR"
echo ""
echo "🎯 LO SVILUPPO PUÒ ORA TESTARE L'APPLICAZIONE AGGIORNATA!"
