'README'
# 🚀 SISTEMA DI DEPLOY AUTONOMO - PORTALE COMMESSE

## 📋 INFRASTRUTTURA
- **Apache HTTPD 2.4**: Reverse proxy su porta 9090
- **Tomcat 10.1**: Application server su porta 8080 (solo localhost)
- **MariaDB 10.11**: Database su porta 3306
- **JDK 21**: Java Runtime

## 🎯 COME USARE (PER LO SVILUPPO)

### 1. DEPLOY DI AGGIORNAMENTI
```bash
# Copia i nuovi file nelle directory:
cp /percorso/nuovo.war ~/nuovo-nix/deploy-packages/latest/commesse.war
cp /percorso/nuovo.sql ~/nuovo-nix/deploy-packages/latest/gestione_commesse.sql

# Esegui il deploy:
cd ~/nuovo-nix
./deploy-update.sh
