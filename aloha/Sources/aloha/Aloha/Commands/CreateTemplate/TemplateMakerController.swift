import Foundation

struct TemplateMakerController {

    let ui: UI

    let templateUseCase: TemplateUseCaseProtocol

    let fileHelper: FileHelper

    func start() {

        // check if user have aloha config
        if !templateUseCase.userHaveTemplateDir() {
            ui.message(Colors.cyan + "There is no" + Colors.reset + " aloha config in this project yet.")
            templateUseCase.createAloha()
            ui.message(Colors.cyan + "🌊 Created aloha config " + Colors.reset + "on current project.")
        }

        // ask what would be the name of the template
        guard let templateName = ui.userInput(
            "Please type the" + Colors.green + " name of the template" +
            Colors.reset + " to be" + Colors.cyan + " created:"
        ) else {
            ui.error("Invalid input")
            return
        }

        // check if name is valid (not empty)
        if !templateUseCase.isValidTemplateName(templateName) {
            ui.error("Invalid template name")
            return
        }

        // check if there is not a template with that name
        if templateUseCase.listTemplates().contains(templateName) {
            ui.error("There is a template with this name already")
            return
        }


        // ask where is the path to source
        guard let source = ui.userInput(
            "Please type the" + Colors.cyan + " path"
            + Colors.reset + " to the source directory that would be the base of the template.\n" +
            "Consider current path as " + Colors.green + fileHelper.currentDir()
        ) else {
            ui.error("Invalid input")
            return
        }

        // check if there is a directory there
        if !fileHelper.exist(source) {
            ui.error("Invalid source directory path")
        }


        // ask what would be the key word
        guard let keyWord = ui.userInput(
            "Please type the key word that would be considered" +
            Colors.cyan + " dynamic" + Colors.reset + " by the template:"
        ) else {
            ui.error("Invalid input")
            return
        }

        // copy eveything to template dir
        print("do stuff ======= ")

        print(templateName)
        print(source)
        print(keyWord)

        // rename eveything
    }
}
