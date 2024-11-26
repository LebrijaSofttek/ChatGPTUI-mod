import Foundation
import SwiftUI

public struct AttributedView: View {
    
    public let results: [ParserResult]
    
    public init(results: [ParserResult]) {
        self.results = results
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(results) { parsed in
                if parsed.isCodeBlock {
                    CodeBlockView(parserResult: parsed)
                        .padding(.bottom)
                        .onAppear {
                            print("-----CodeBlockView Parsed: \n\(parsed.isCodeBlock)\n\(String(describing: parsed.codeBlockLanguage))\n\(parsed.attributedString)")
                        }
                } else {
                    Text(parsed.attributedString)
                        .textSelection(.enabled)
                        .onAppear {
                            print("-----CodeBlockView Parsed: \n\(parsed.isCodeBlock)\n\(String(describing: parsed.codeBlockLanguage))\n\(parsed.attributedString)")
                        }
                }
            }
        }
    }
}
