# aloha

🏝️ Generic template generator

Aloha is a command line tool focused on speed-up boring tasks such as creating bureaucratic architecture file structures.
It follows templates provided by the user and apply then at the designated path renaming files and content if needed.

## How to run:

- First compile the project `make release`
- The executable will appear at `aloha/.build/release/aloha`
- You can either add to `$PATH` or set an `alias`

## Run using docker:

- build a image with aloha `docker build -t aloha:1.0 .`
- run the contaier passing the command parameters `docker run --rm -v "$PWD":/home/user/app aloha:1.0 aloha`

## How to create templates:

- Run `aloha start` on your project directory to create the basic file structure. 
- Create the templates at `aloha/templates` each directory here is considered a different template.

## Template config:

- Create a example template `mkdir aloha/templates/my_example`
- Now inside the `aloha/templates/my_example` create a file `control.json`, this defines where each file or directory should be moved to.

## Templates

- The actual templates are created just like a file structure using directories and files.
- The key word `__init__` indicates where the argument `name` should be replaced on file names and file content.
- example call name Aloha for `__name__ExampleDir` becomes `AlohaExampleDir`.

## Control.json

- The structure of the `control.json` is:

```json
{
    "targets": [
        {
          "model": "__name__ExampleDir",
          "destination": "SomeProject"
        },
        {
          "model": "Package.swift",
          "destination": "SomeProject"
        },
        {
          "model": "__name__Coordinator.swift",
          "destination": "SomeProject"
        }
    ]
}
```

The key `model` indicates where is the template file located, like `aloha/templates/my_example/__name__ExampleDir` and the key `destination` is the path relative to where the file will be created.
So in the first item `aloha/templates/my_example/__name__ExampleDir` will be moved to `CurrentDir/SomeProject/__name__ExampleDir` (key word `__name__` will be renamed for the parameter `name`).

