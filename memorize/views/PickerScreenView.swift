//
//  PickerScreenView.swift
//  memorize
//
//  Created by Artem Japparov on 06.01.2021.
//

import SwiftUI


//
//struct PickerScreenView: View {
//
//    let header: String
//    @State var selectedValue: String = ""
//    var possibleValues: Array<String> = []
//
//    @State var open = false
//        @State var popoverSize = CGSize(width: 300, height: 300)
//
//
//    init(
//        header: String,
//         selectedValue: String,
//        possibleValues: Array<String>
//    ) {
//        self.header = header
//        self.selectedValue = selectedValue
//        self.possibleValues = possibleValues
//    }
//
//    var body: some View {
////        NavigationView {
////            Picker("Pet", selection: $selectedValue) {
////                ForEach(possibleValues, id: \.self) { item in
////                    Text(item)
////                }
////            }
////                .pickerStyle(WheelPickerStyle())
////        }
//
//
////        WithPopover(
////                    showPopover: $open,
////                    popoverSize: popoverSize,
////                    content: {
////                        Button(action: { self.open.toggle() }) {
////                            Text("Tap me")
////                        }
////                },
////                    popoverContent: {
////                        VStack {
////                            Button(action: { self.popoverSize = CGSize(width: 300, height: 600)}) {
////                                Text("Increase size")
////                            }
////                            Button(action: { self.open = false}) {
////                                Text("Close")
////                            }
////                        }
////                })
//                }
//            }
//    }
//}


struct PickerScreenView: View {
    @State private var showModal = false

    init(
            header: String,
             selectedValue: String,
            possibleValues: Array<String>
        ) {
          
        }
    
    
    var body: some View {
        VStack {
            Button("Show modal") {
                self.showModal = true
            }
        }.sheet(isPresented: $showModal, onDismiss: {
            print(self.showModal)
        }) {
            ModalView(message: "This is Modal view")
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    let message: String

    var body: some View {
        VStack {
            Text(message)
            Button("Dismiss") {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}



struct PickerScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PickerScreenView(header: "1", selectedValue: "meow", possibleValues: ["meow", "woof"])
        
    }
}

struct WithPopover<Content: View, PopoverContent: View>: View {
    
    @Binding var showPopover: Bool
    var popoverSize: CGSize? = nil
    let content: () -> Content
    let popoverContent: () -> PopoverContent
    
    var body: some View {
        content()
        .background(
            Wrapper(showPopover: $showPopover, popoverSize: popoverSize, popoverContent: popoverContent)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
    
    struct Wrapper<PopoverContent: View> : UIViewControllerRepresentable {
        
        @Binding var showPopover: Bool
        let popoverSize: CGSize?
        let popoverContent: () -> PopoverContent
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<Wrapper<PopoverContent>>) -> WrapperViewController<PopoverContent> {
            return WrapperViewController(
                popoverSize: popoverSize,
                popoverContent: popoverContent) {
                    self.showPopover = false
            }
        }
        
        func updateUIViewController(_ uiViewController: WrapperViewController<PopoverContent>,
                                    context: UIViewControllerRepresentableContext<Wrapper<PopoverContent>>) {
            uiViewController.updateSize(popoverSize)

            if showPopover {
                uiViewController.showPopover()
            }
            else {
                uiViewController.hidePopover()
            }
        }
    }
    
    class WrapperViewController<PopoverContent: View>: UIViewController, UIPopoverPresentationControllerDelegate {
        
        var popoverSize: CGSize?
        let popoverContent: () -> PopoverContent
        let onDismiss: () -> Void
        
        var popoverVC: UIViewController?

        required init?(coder: NSCoder) { fatalError("") }
        init(popoverSize: CGSize?,
             popoverContent: @escaping () -> PopoverContent,
             onDismiss: @escaping() -> Void) {
            self.popoverSize = popoverSize
            self.popoverContent = popoverContent
            self.onDismiss = onDismiss
            super.init(nibName: nil, bundle: nil)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        func showPopover() {
            guard popoverVC == nil else { return }
            let vc = UIHostingController(rootView: popoverContent())
            if let size = popoverSize { vc.preferredContentSize = size }
            vc.modalPresentationStyle = UIModalPresentationStyle.popover
            if let popover = vc.popoverPresentationController {
                popover.sourceView = view
                popover.delegate = self
            }
            popoverVC = vc
            self.present(vc, animated: true, completion: nil)
        }
        
        func hidePopover() {
            guard let vc = popoverVC, !vc.isBeingDismissed else { return }
            vc.dismiss(animated: true, completion: nil)
            popoverVC = nil
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            popoverVC = nil
            self.onDismiss()
        }
        
        func updateSize(_ size: CGSize?) {
            self.popoverSize = size
            if let vc = popoverVC, let size = size {
                vc.preferredContentSize = size
            }
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none // this is what forces popovers on iPhone
        }
        
    }
}
