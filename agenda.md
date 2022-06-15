## fix project
random_pet.name.id as main resource group name causes conflicts, fix

maybe build the first version before the load balanced one?
it's highly complicated...

need to figure out a way to itirate machine on nics network
okta needs 3 different ip's?

- naming conventions:
- this is excellent: frontend_subnet
- modify: myterraformnetwork, myterraformnsg
- this is mediocre- privatenet

need to build a load balance first-
health probes
BackEndAddressPool -1lb health rule

exit password