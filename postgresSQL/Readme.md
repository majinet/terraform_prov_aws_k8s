helm install my-release -f values.yaml my-repo/postgresql

NAME: my-feast
LAST DEPLOYED: Thu Mar  9 08:04:33 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql
CHART VERSION: 12.2.2
APP VERSION: 15.2.0

** Please be patient while the chart is being deployed **

PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    my-feast-postgresql.default.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_ADMIN_PASSWORD=$(kubectl get secret --namespace default my-feast-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

To get the password for "feast" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-feast-postgresql -o jsonpath="{.data.password}" | base64 -d)

To connect to your database run the following command:

    kubectl run my-feast-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:15.2.0-debian-11-r5 --env="PGPASSWORD=$POSTGRES_PASSWORD" \
      --command -- psql --host my-feast-postgresql -U feast -d feast -p 5432

    > NOTE: If you access the container using bash, make sure that you execute "/opt/bitnami/scripts/postgresql/entrypoint.sh /bin/bash" in order to avoid the error "psql: local user with ID 1001} does not exist"

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/my-feast-postgresql 5432:5432 &
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U feast -d feast -p 5432