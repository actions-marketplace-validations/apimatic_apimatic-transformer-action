# APIMATIC Transformer Action

This [Github Action](https://github.com/actions) uploads and converts any API Specification into an of the supported formats listed [here](https://www.apimatic.io/transformer/#supported-formats).

## API Description Format
### A format is a unique identifier for transformation. E.g. swagger, raml, wadl, postman

### Formats Supported

|Name |Description|
|---	|---	|
|apimatic|The APIMatic format|
|wadl2009|The WADL format|
|swagger10|The Swagger 1.2 format|
|swagger20|The Swagger 2.0 JSON format|
|swaggeryaml|The Swagger 2.0 YAML format|
|apiblueprint|The APIBluePrint format|
|raml|The RAML 0.8 format|
|raml10|The RAML 1.0 format|
|postman10|The Postman 1.0 format|
|postman20|The Postman 2.0 format|
|openapi3json|The OpenAPI 3.0 Json format|
|openapi3yaml|The OpenAPI 3.0 Yaml format|
|wsdl|The WSDL format|

## Usage

Basic usage:
```
    steps:
      # you must check out the repository
      - name: Checkout
        uses: actions/checkout@v2
      - name: Transform API Spec
        uses: mujjazi/apimatic-transformer-actions@master
        id: transform
        with:
         auth: ${{ secrets.AUTH }}
     # Use the Transformed API Spec as output from our action (id:transform)
      - name: Get the API Spec UR
        run: echo "${{ steps.transform.outputs.specurl }}"
```

This action requires [actions/checkout@v2](https://github.com/actions/checkout) as a first step.

## Example Workflow

```
name: APITransformer
on: [push]

jobs:
  Test_Transformer:
    runs-on: ubuntu-latest
    name: Testing API Transformer Action
    steps:
      # you must check out the repository
      - name: Checkout
        uses: actions/checkout@v2
      - name: Transform API Spec
        uses: ./ # Uses an action in the root directory
        id: transform
        with:
         auth: ${{ secrets.AUTH }}
     # Use the Transformed API Spec as output from our action (id:transform)
      - name: Get the API Spec UR
        run: echo "${{ steps.transform.outputs.specurl }}"

```

It is recommended to create an [encrypted secret](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets) for the APITree API token (`apitree_token`).

## Inputs

### The input parameter that is passed in the workflow is the Basic Authorization token, It is highly recommended to store the AUTH token in GitHub Secrets.
### You can create your Basic Authorization token from this [website](https://www.blitter.se/utils/basic-authentication-header-generator/)
### It will generate a string like this for you: Authorization: Basic cmFuZG9tQGdtYWlsLmNvbTpyYW5kb20=
### Make sure to add the complete string Authorization: Basic cmFuZG9tQGdtYWlsLmNvbTpyYW5kb20= in your secret.

* `auth`: (**Required**) The API Token which is needed for authorization. Register an [APIMatic](https://www.apimatic.io/account/register) account and purchase a subscription to be authorized with you email and password.

### There are three other inputs that are passed to this action:
* fileUrl
* exportFormat
* codeGenVersion

### You need to create a json file named transform.json with API Specification URL specified against fileUrl, Required Format against exportFormat and codeGenVersion as 1.
[Example File](https://github.com/mujjazi/apimatic-transformer-action/blob/master/transform.json)

## Outputs

### API Specification URL is generated which can be used to download the transformed API specification in the required format but this URL only works with authorization therefore user need to login to APIMATIC and then launch this URL

## Feature requests and bug reports

Please file feature requests and bug reports as [github issues](https://github.com/mujjazi/apimatic-transformer-action/issues).

## License

See [LICENSE](LICENSE)
