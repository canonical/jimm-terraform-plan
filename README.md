# JIMM terraform plan
This is the terraform plan to deploy  [JIMM](https://canonical-jaas-documentation.readthedocs-hosted.com/en/v3/).

## Requirements

- juju microk8s controller: https://microk8s.io/docs/getting-started
  > Make sure metallb add-ons is enabled: https://microk8s.io/docs/addon-metallb
- vault client:  https://snapcraft.io/vault
- terraform client: https://snapcraft.io/terraform
- valid client_id/client_secret for oauth: An example is to use Google https://developers.google.com/identity/protocols/oauth2/limited-input-device#creatingcred

## Deploy

- in `main.tf@juju provider` you can set the fields to connect to your microk8s juju controller. 
    > If you have the Juju CLI set up on your machine, you don't need to set any credentials because terraform will pick those up using your juju CLI from the controller you are currently switched to.
- After having generated the client_id and client_secret you can create a file called `secrets.tfvars` with this format:
  ```
  client_id     = "<client_id>"
  client_secret = ">client_secret>"
  ```

Now you can setup terraform:
`terraform init`

Check out the plan:
`terraform plan`

Apply it:
`terraform apply -var-file=secrets.tfvars`

You have to unseal vault:
https://charmhub.io/vault-k8s/docs/h-getting-started#h-4-set-up-the-vault-cli


Now, everything should be `active`.

> If JIMM is blocked waiting for the Vault relation, change a setting to force a restart.
> Ex: `juju config jimm juju-dashboard-location=""`

If you run:
`juju run ingress/0 show-proxied-endpoints` you should see the endpoint for JIMM.

Find the IP address traefik exposes your services on:
`kubectl get service ingress-lb -n jimm` -> look for `external_ip`

Add JIMM's endpoint to your `/etc/hosts`:
`sudo echo <external_ip> jimm.localhost.com >> /etc/hosts`
> The reason why you need a .com domain is that most OAuth provider 

Import JIMM's certificate to your host machine:
```
juju run jimm-cert/0 get-ca-certificate --quiet | yq .ca-certificate | sudo tee /usr/local/share/ca-certificates/jimm-test.crt 
sudo update-ca-certificates --fresh
```

Now test JIMM:  
`curl https://jimm.localhost.com/jimm-jimm/debug/status`

`juju login jimm.localhost.com:443/jimm-jimm -c jimm-k8s` -> prompts you to login into Google


