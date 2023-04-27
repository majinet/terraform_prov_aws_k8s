microk8s helm3 repo add bitnami https://charts.bitnami.com/bitnami
microk8s helm3 install my-release -f postgresSQL/config/values.yaml bitnami/postgresql

NAME: postgres-release
LAST DEPLOYED: Sat Apr  1 01:41:41 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql
CHART VERSION: 12.2.6
APP VERSION: 15.2.0

** Please be patient while the chart is being deployed **

PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    postgres-release-postgresql.default.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_ADMIN_PASSWORD=$(kubectl get secret --namespace default postgres-release-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

To get the password for "feast" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.password}" | base64 -d)

To connect to your database run the following command:

    kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:15.2.0-debian-11-r5 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host postgresql -U feast -d feast -p 5432

    > NOTE: If you access the container using bash, make sure that you execute "/opt/bitnami/scripts/postgresql/entrypoint.sh /bin/bash" in order to avoid the error "psql: local user with ID 1001} does not exist"

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/postgres-release-postgresql 5432:5432 &
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U feast -d feast -p 5432

WARNING: The configured password will be ignored on new installation in case when previous Posgresql release was deleted through the helm command. In that case, old PVC will have an old password, and setting it through helm won't take effect. Deleting persistent volumes (PVs) will solve the issue.

CREATE TABLE titanic_survive_svc_v1 (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INTEGER,
    email TEXT UNIQUE
);

INSERT INTO titanic_survive_svc_v1 (name, age, email) VALUES ('John Doe', 30, 'john.doe@example.com');