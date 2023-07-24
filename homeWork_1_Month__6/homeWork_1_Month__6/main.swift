//
//  main.swift
//  homeWork_1_Month__6
//
//  Created by Аяз on 24/7/23.
//

import Foundation

protocol PrintingStrategy {
    func printDocument(_ document: Any)
}

class TextPrintingStrategy: PrintingStrategy {
    func printDocument(_ document: Any) {
        if let textDocument = document as? String {
            print("Печать текстового документа:")
            print(textDocument)
        } else {
            print("Ошибка: Невозможно распознать документ для печати.")
        }
    }
}

class ImagePrintingStrategy: PrintingStrategy {
    func printDocument(_ document: Any) {
        if let imageDocument = document as? String {
            print("Печать изображения:")
            print("[\(imageDocument)]")
        } else {
            print("Ошибка: Невозможно распознать документ для печати.")
        }
    }
}

class Printer {
    private var printingStrategy: PrintingStrategy

    init(printingStrategy: PrintingStrategy) {
        self.printingStrategy = printingStrategy
    }

    func setPrintingStrategy(_ strategy: PrintingStrategy) {
        self.printingStrategy = strategy
    }

    func printDocument(_ document: Any) {
        printingStrategy.printDocument(document)
    }
}

class OldPrinterAdapter: PrintingStrategy {
    private let oldPrinter: OldPrinter

    init(oldPrinter: OldPrinter) {
        self.oldPrinter = oldPrinter
    }

    func printDocument(_ document: Any) {
        if let imageDocument = document as? String {
            let formattedDocument = "[\(imageDocument)]"
            oldPrinter.printImage(formattedDocument)
        } else {
            print("Ошибка: Невозможно распознать документ для печати.")
        }
    }
}

class OldPrinter {
    func printImage(_ image: String) {
        print("Старый принтер печатает изображение: \(image)")
    }
}

let textDocument = "Это текстовый документ."
let imageDocument = "Имя_файла_изображения.png"

let textPrinter = Printer(printingStrategy: TextPrintingStrategy())
textPrinter.printDocument(textDocument)

let imagePrinter = Printer(printingStrategy: ImagePrintingStrategy())
imagePrinter.printDocument(imageDocument)

let oldPrinter = OldPrinter()
let oldPrinterAdapter = OldPrinterAdapter(oldPrinter: oldPrinter)
let documentForOldPrinter = "Файл_изображения.jpg"
imagePrinter.setPrintingStrategy(oldPrinterAdapter)
imagePrinter.printDocument(documentForOldPrinter)
