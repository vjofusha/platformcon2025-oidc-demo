# PlatformCON 2025

# Secure Deployments on Github using OIDC (OpenID Connect)

Managing secrets across multiple tools and environments can quickly become a headache. Static credentials need to be stored, secured, rotated, and audited, and each new integration adds further complexity. It's not just a security risk; it's also a maintenance burden. This is where we need to consider a modern approach to authentication that replaces static secrets with short-lived, verifiable identity tokens. 

# OpenID Connect (OIDC)

Built on top of OAuth 2.0, OpenID Connect (OIDC) is an authentication protocol designed to enable secure and standardized verification of user identities. It allows clients to request and receive information about authenticated sessions and end users through ID Tokens, which carry identity data. Widely used with federated identity providers (IdPs), OIDC is designed to work with modern APIs, making it a reliable choice for verifying identities across diverse systems.

## Why does it matter for CI/CD? 
* **Improved Security**: OIDC enables CI/CD systems to use short-lived, dynamically generated tokens instead of static credentials, reducing the risk of credential leaks or misuse.

* **Credential Management Simplification**: With OIDC, secrets don't need to be stored or rotated manually in your CI/CD pipelines. The identity provider (e.g., AWS, Azure, GCP) issues tokens on demand.

* **Fine-Grained Access Control**: OIDC integrates with Cloud Identity and Access Management (IAM) systems, enabling precise control over which resources the CI/CD pipeline can access.

* **Scalability**: Leveraging federated identity and role-based access, OIDC scales effectively for large teams and organizations, simplifying access management across multiple environments.

* **Compliance**: Using short-lived, identity-based authentication instead of static credentials supports best practices in access management and aligns well with common security and compliance expectations like SOC 2, ISO 27001, and PCI-DSS.
