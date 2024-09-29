//
//  TapBiographyText.swift
//  My Family Tree
//
//  Created by Artak on 29.09.24.
//



import SwiftUI

struct ResizableTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var dynamicHeight: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.white
        textView.font = .systemFont(ofSize: 18)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: ResizableTextView
        
        init(_ textView: ResizableTextView) {
            self.parent = textView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            DispatchQueue.main.async {
                let newHeight = textView.contentSize.height
                self.parent.dynamicHeight = min(newHeight, 200)
            }
        }
    }
}
