🎯 COME USARE QUESTO SISTEMA DI DEPLOY:

1. PER LO SVILUPPO (aggiornare l'app):
   a) Copia i nuovi file nelle directory:
      - commesse.war → deploy-packages/latest/commesse.war
      - gestione_commesse.sql → deploy-packages/latest/gestione_commesse.sql
      - File Angular → deploy-packages/latest/frontend/ (opzionale)
   
   b) Esegui: ./deploy-update.sh

2. PER TESTARE:
   - Frontend: http://localhost:9090/
   - Backend API: http://localhost:9090/commesse-0.0.1-SNAPSHOT/
   - Tomcat diretto: http://localhost:8080/commesse-0.0.1-SNAPSHOT/
   - Database: mysql -h 127.0.0.1 -P 3306 -u commesse -pcommesse

3. COMANDI UTILI:
   - ./start-all.sh          # Avvia tutto
   - ./stop-all.sh           # Ferma tutto
   - ./status.sh             # Verifica stato
   - ./deploy-update.sh      # Deploy aggiornamenti
   - ./quick-update.sh file.war file.sql  # Deploy rapido

4. LOG PER DEBUG:
   - Spring Boot: tail -f tomcat10/logs/catalina.out
   - Apache: tail -f apache/logs/error.log
   - Database: tail -f mysql-data/mysql-error.log
