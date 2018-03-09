# Overview
A set of Apigee Edge API proxies to test Sonar or API Monitoring feature.


# Deploy Proxy

```sh
cd <proxy directory>
$ mvn apigee-enterprise:deploy -Ptest -Dusername=$EDGE_USERNAME -Dpassword=$EDGE_PASSWORD -Dorg=$EDGE_ORG -Denv=$EDGE_ENV
```

or

```sh
./deploy.sh <proxy directory name or all>
```

# Set up Alerts

Setup below alerts on Analyze -> API Monitoring -> Alerts -> Settings

- Alert to notify email or webhook (sonar-webhook-api) when 4xx error rate is above 20%
- Alert to notify email or webhook (sonar-webhook-api) when 5xx error rate is above 5%
- Alert to notify email or webhook (sonar-webhook-api) when latency is more than 3000ms for sonar-delay-api proxy

# Test

## Option 1

Put the below commands in a script file and run it.

```sh
ab -c 5 -n 100 -q https://<org>-<env>.apigee.net/sonar/status/2xx
ab -c 5 -n  20 -q https://<org>-<env>.apigee.net/sonar/status/4xx
ab -c 5 -n  10 -q https://<org>-<env>.apigee.net/sonar/status/5xx
ab -c 5 -n   5 -q https://<org>-<env>.apigee.net/sonar/delay/5
```

## Option 2

Install parallel

```sh
brew install parallel
```

Put below URLs in a file urls.txt

```
https://<org>-<env>.apigee.net/sonar/status/2xx
https://<org>-<env>.apigee.net/sonar/status/4xx
https://<org>-<env>.apigee.net/sonar/status/5xx
https://<org>-<env>.apigee.net/sonar/delay/5
```

Run Apache ab with parallel

```sh
parallel "ab -n {2} -c 10 {1}" :::: urls.txt :::+ 100 50 20 10
```

# Observe the API Monitoring Dashboard
See Analyze -> API Monitoring


