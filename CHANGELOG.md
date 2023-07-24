# Changelog

## [1.3.0](https://github.com/Excoriate/terraform-registry-aws-storage/compare/v1.2.4...v1.3.0) (2023-07-24)


### Features

* add ssm parameter store module ([922f5d0](https://github.com/Excoriate/terraform-registry-aws-storage/commit/922f5d078a8be25acefc83a72f6a66ea3a90fd0e))


### Bug Fixes

* workflows ([a8b8f1d](https://github.com/Excoriate/terraform-registry-aws-storage/commit/a8b8f1df3c99049f3c48da575852ea4028a2e3aa))
* workflows ([05c9b2d](https://github.com/Excoriate/terraform-registry-aws-storage/commit/05c9b2d016d3a808090c4641f775aa4901e22c7c))


### Other

* add updated module in the main readme.md description ([81eaaec](https://github.com/Excoriate/terraform-registry-aws-storage/commit/81eaaeced950518d08ebaf1168be59e1ff341d6b))

## [1.2.4](https://github.com/Excoriate/terraform-registry-aws-storage/compare/v1.2.3...v1.2.4) (2023-05-10)


### Bug Fixes

* Add feature flag to disable built-in permissions ([c2bf19b](https://github.com/Excoriate/terraform-registry-aws-storage/commit/c2bf19b9bb632e12df58325a3eb80eaf43deae57))

## [1.2.3](https://github.com/Excoriate/terraform-registry-aws-storage/compare/v1.2.2...v1.2.3) (2023-05-08)


### Bug Fixes

* Add correct arn output for rotation lambda ([23724aa](https://github.com/Excoriate/terraform-registry-aws-storage/commit/23724aa1a0bc072da2fadf2dc4d6f02cb585677f))

## [1.2.2](https://github.com/Excoriate/terraform-registry-aws-storage/compare/v1.2.1...v1.2.2) (2023-05-08)


### Bug Fixes

* Add correct lambda lookup capability, by function name ([75a21ff](https://github.com/Excoriate/terraform-registry-aws-storage/commit/75a21ff7d0072c403b5738c4f159aec99a0e27e6))

## [1.2.1](https://github.com/Excoriate/terraform-registry-aws-storage/compare/v1.2.0...v1.2.1) (2023-05-07)


### Other

* Fix release-please workflow ([4f0aaaa](https://github.com/Excoriate/terraform-registry-aws-storage/commit/4f0aaaae0eb972127e22397bf64c356168161833))

## [1.2.0](https://github.com/Excoriate/terraform-registry-aws-storage/compare/v1.1.0...v1.2.0) (2023-05-07)


### Features

* Add capability for generating random secret value ([#3](https://github.com/Excoriate/terraform-registry-aws-storage/issues/3)) ([790d0d2](https://github.com/Excoriate/terraform-registry-aws-storage/commit/790d0d293776d3e3bcdff1ed7c022c04f16e2506))

## [1.1.0](https://github.com/Excoriate/terraform-registry-aws-storage/compare/v1.0.0...v1.1.0) (2023-05-03)


### Features

* add cli for populating secrets ([9284b42](https://github.com/Excoriate/terraform-registry-aws-storage/commit/9284b42fa1f9f65feb32ea9956e60e8b2c1369aa))
* Add completion of TF code for rotating secrets ([77f20d2](https://github.com/Excoriate/terraform-registry-aws-storage/commit/77f20d2deab6260967f5a14770c49a35460001da))
* add custom permissions and policies capabilities ([b497982](https://github.com/Excoriate/terraform-registry-aws-storage/commit/b4979823ec4a8c583b8904c070880c2454379424))
* add default resource policy ([754a2b2](https://github.com/Excoriate/terraform-registry-aws-storage/commit/754a2b23fc0793185809e01c69d2e75dc36dac14))
* add deployment bucket module ([f77fe3d](https://github.com/Excoriate/terraform-registry-aws-storage/commit/f77fe3d166a0a84a592f8d03041c25d3943adb18))
* add dynamodb module ([3911e05](https://github.com/Excoriate/terraform-registry-aws-storage/commit/3911e05cdfc9a242693f26d1474b22538ffbee7c))
* add minimal configuration for an S3 bucket ([079ab64](https://github.com/Excoriate/terraform-registry-aws-storage/commit/079ab6468f45f0877c7238c5450b11e82fe21891))
* Add minimal rotation module ([031cf48](https://github.com/Excoriate/terraform-registry-aws-storage/commit/031cf489a802102a9997602a2185cf647f6829b0))
* add mvp secrets-manager module ([6735b07](https://github.com/Excoriate/terraform-registry-aws-storage/commit/6735b07a2261bfb4898289f5ab37398fe4968ac9))
* add prefix in path capability ([b3736ae](https://github.com/Excoriate/terraform-registry-aws-storage/commit/b3736ae4f6de4a199ae071c467be98d19250831e))
* Add public access lock ([7112ab6](https://github.com/Excoriate/terraform-registry-aws-storage/commit/7112ab6bcd83dbbb650a0351dff6a6b4daefba45))
* Add s3 object-storage module ([86558b7](https://github.com/Excoriate/terraform-registry-aws-storage/commit/86558b77a194b434d1579e81f2a79a39f97a7772))
* Add sse capability ([c7d56e6](https://github.com/Excoriate/terraform-registry-aws-storage/commit/c7d56e6f31d37cb3f77d1f3550cfc54a752fc7d5))
* add tested recipes ([13254d1](https://github.com/Excoriate/terraform-registry-aws-storage/commit/13254d1bd4675470c3b90c90d0410a6d03f0bb62))
* Add transfer acceleration capability ([f0801db](https://github.com/Excoriate/terraform-registry-aws-storage/commit/f0801db6b06622115a67e02ee3fcaea69fb661cb))
* Add versioning capability ([1d3b40e](https://github.com/Excoriate/terraform-registry-aws-storage/commit/1d3b40ee9fca893c602308f2484e617dceb097d8))
* first commit ([0d15da9](https://github.com/Excoriate/terraform-registry-aws-storage/commit/0d15da9dadea5a6f3df71d0faf6997e269f6b2a3))


### Bug Fixes

* amend policy name when it includes slash chars ([0e7b87a](https://github.com/Excoriate/terraform-registry-aws-storage/commit/0e7b87afe7278b9343752c83470615bcf49fc0eb))
* replication ([6c3d89f](https://github.com/Excoriate/terraform-registry-aws-storage/commit/6c3d89fff568401fbb19c6e58d535258e608128b))
* small fixes on secrets manager cli ([648d016](https://github.com/Excoriate/terraform-registry-aws-storage/commit/648d016287838b2c9df7e74fa24dfa431c9c2d07))


### Other

* add docs ([a17eb47](https://github.com/Excoriate/terraform-registry-aws-storage/commit/a17eb47d6c83de9129737edbf20f2f1ac7ec3c6f))
* add docs ([72e4fee](https://github.com/Excoriate/terraform-registry-aws-storage/commit/72e4fee542e709d762abb2bd039643a6e3ab8ca3))
* add missing outputs ([577fb46](https://github.com/Excoriate/terraform-registry-aws-storage/commit/577fb46fa98696fce5cd352730d141ab9ddd7a22))
* fix workflow ([6658400](https://github.com/Excoriate/terraform-registry-aws-storage/commit/6658400a0c48ea2b27b77b8c1de7308e4f4d0347))
* fix workflows ([648287b](https://github.com/Excoriate/terraform-registry-aws-storage/commit/648287b915019ab4e11c3072892a957cbeb55c60))


### Docs

* add updated readme ([3b4ca93](https://github.com/Excoriate/terraform-registry-aws-storage/commit/3b4ca93d8e1d9f8b89be418c322e87b5826d9d74))
