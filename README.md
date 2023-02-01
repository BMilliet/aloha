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
- run the contaier passing the command parameters `docker run --rm -v "$PWD":/home/user/proj aloha:1.0 aloha`

## How to create templates:

- Run `aloha start` on your project directory to create the basic file structure. 
- Create the templates at `aloha/templates` each directory here is considered a different template.

## Template config:

- Create a example template `mkdir aloha/templates/my_example`
- Now inside the `aloha/templates/my_example` create a file `control.json`, this defines where each file or directory should be moved to.

## Templates

- The actual templates are created just like a file structure using directories and files.
- The key word `__name__` indicates where the argument `name` should be replaced on file names and file content.
- example call name Aloha for `__name__ExampleDir` becomes `AlohaExampleDir`.

## Control.json

- `targets` the array of items with the targets indicating from which template model should be copied to.
- `model` is where in local template that specific directory of file should be copied from.
- `destination` is where the `model` template should be copied to and renamed with the parameter `name`.
- `justCopy` is an array with the name of files or directories that should only be copied, their content wont be read.

## Control.json example

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
    ],
    "justCopy": [
      "project.xcworkspace",
      "Assets.xcassets",
      "Base.lproj",
      "Info.plist",
      ".gitignore"
  ]
}
```

