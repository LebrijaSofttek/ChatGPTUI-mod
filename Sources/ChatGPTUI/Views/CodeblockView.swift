import SwiftUI
import Markdown

enum HighlighterConstants {
    static let color = Color(red: 38/255, green: 38/255, blue: 38/255)
}

struct CodeBlockView: View {
    
    let parserResult: ParserResult
    @State var isCopied = false
    
    var body: some View {
        VStack(alignment: .leading) {
            header
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.gray)
            
            ScrollView(.horizontal, showsIndicators: true) {
                Text(parserResult.attributedString)
                    .padding(.horizontal, 16)
                    .textSelection(.enabled)
            }
        }
        .background(.background)
        .cornerRadius(8)
    }
    
    var header: some View {
        HStack {
            if let codeBlockLanguage = parserResult.codeBlockLanguage {
                Text(codeBlockLanguage.capitalized)
                    .font(.headline.monospaced())
                    .foregroundColor(.white)
            }
            Spacer()
            button
        }
    }
    
    @ViewBuilder
    var button: some View {
        if isCopied {
            HStack {
                Text("Copied")
                    .foregroundColor(.white)
                    .font(.subheadline.monospaced().bold())
                Image(systemName: "checkmark.circle.fill")
                    .imageScale(.large)
                    .symbolRenderingMode(.multicolor)
            }
            .frame(alignment: .trailing)
        } else {
            Button {
                let string = NSAttributedString(parserResult.attributedString).string
                #if os(macOS)
                NSPasteboard.general.setString(string, forType: .string)
                #else
                UIPasteboard.general.string = string
                #endif
                
                withAnimation {
                    isCopied = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isCopied = false
                    }
                }
            } label: {
                Image(systemName: "doc.on.doc")
            }
            .foregroundColor(.white)
        }
    }
}
