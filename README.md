# LiveWell Test
Mobile app to display/download pictures from the [pexels.com api](https://www.pexels.com/api/).

* Developed in Flutter Channel stable, 3.3.1
* Tested on iOS and Android.

## Requirements
> ...project that uses RiverPod with HookWidgets, and any image API to display images in a grid on the interface.
Give the user the ability to download the images too. And show appropriate message when connectivity is an issue.

## Screenshots
<p float="left">
<img src="https://user-images.githubusercontent.com/70621340/221586888-a81f556f-0f07-4a50-a633-4128f6c1a501.png"  width="170" height="340">
<img src="https://user-images.githubusercontent.com/70621340/221586892-e9b89e10-87c2-4bce-a515-ec7e11e79ff2.png"  width="170" height="340">
<img src="https://user-images.githubusercontent.com/70621340/221586899-cf3f9e92-09f3-495d-bb84-a7270f47289f.png"  width="170" height="340">
<img src="https://user-images.githubusercontent.com/70621340/221586902-6a875927-f24d-4c9f-9a4f-b11f932428fb.png"  width="170" height="340">
<img src="https://user-images.githubusercontent.com/70621340/221586909-5d600166-bf00-4989-8385-3644dfc0226e.png"  width="170" height="340">
<img src="https://user-images.githubusercontent.com/70621340/221587542-0f0183c9-3ffe-4089-b45f-3f89c9a18eb8.png"  width="170" height="340">
<img src="https://user-images.githubusercontent.com/70621340/221586905-1e82a61c-4712-4af3-b7f9-157af1d8182e.png"  width="345" height="140">
<img src="https://user-images.githubusercontent.com/70621340/221590689-7be85913-eeea-4c87-bca2-42c2607f25d4.png"  width="170" height="340">
<img src="https://user-images.githubusercontent.com/70621340/221587947-0b472b61-d860-41db-8fa8-9cd64208defd.png"  width="170" height="340">
</p>

## Architecture

The project implements a simple clean architecture, with:
* a <code>core</code> isolated from the rest of the app (is a Dart package) with the bussiness logic, contracts, services abstractions and domain models, 
* a <code>data</code> layer with the service implementations and
* a presentation layer with the <code>features</code> and the components library <code>core_ui</code>.

<img width="1000" height="400" src="https://user-images.githubusercontent.com/70621340/221600069-945a4148-c57a-4aa1-a391-073316cab705.png">

* Notice that, for simplicity and scope of the project, only the <code>core</code> has been extracted in one package.

## Stack
  * dio: network operations
  * flutter_dotenv: protect api key
  * flutter_hooks: syntactic sugar / requirement
  * gallery_saver: store picture in device gallery
  * get_it: dependency injection
  * hooks_riverpod: tate management
  * path_provider: temporary downloaded picture path
  * permission_handler: access device storage
  * visibility_detector: ui need
  * dev_dependencies: mockito (test), build_runner (code generation, required by mockito), flutter_lints (linting)

## Unit tests
Run <code>flutter test</code> to run all units tests in the app (<code>PictureGridViewModel</code> full coverage)




