# aloha

🏝️ Generic template generator

Aloha is a Command line tool focuses on speed-up boring tasks such as creating bureaucratic architecture files structures.
It follows templates provided by the user and apply then at the designated path renaming files and content if needed.

## How to run:

- First compile the project `make release`
- The executable will appear at `aloha/.build/release/aloha`
- You can either add to `$PATH` or set an `alias`

## How to create templates:

- Run `aloha start` on yout project directory to create the basic structure 
- Create the templates at `Aloha/templates` each directory here is considered a different template.

## Template config:

- Create a example template `mkdir Aloha/templates/my_example`
- Now inside the `Aloha/templates/my_example` create a file `control.json`, this defines where each file or directory should be moved to.

## Templates

- The actual templates are created just like a file structure using directories and files with extensions.
- The key word `__init__` indicates where the argument `name` should be replaced, on file names and file content.
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

Model indicates where is the file located at `Aloha/templates/my_example` like `Aloha/templates/my_example/__name__ExampleDir` and the destination is the path relative to current directory where the file will be created.
So in the first item `Aloha/templates/my_example/__name__ExampleDir` will be moved to `CurrentDir/SomeProject/__name__ExampleDir` (key word `__name__` will be renamed for the parameter `name`).

