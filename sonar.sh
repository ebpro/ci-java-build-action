./mvn.sh sonar:sonar \
  -D sonar.branch.name=$(git rev-parse --abbrev-ref HEAD|tr / _ ) \
  -DskipTests=true \
  -Dsonar.language=java \
  -Dsonar.report.export.path=sonar-report.json \
  -Dsonar.host.url=http://localhost:9000 \
  --activate-profiles sonar
