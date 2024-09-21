//
//  About_Storage.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct About_Storage: View {
    // @AppStorage, @SceneStorage
    // 항상 즉시 저장되는 것은 아니다.
    // 하지만, 명시적으로는 홈으로 돌아가는 시점에 값을 저장한다.
    
    // @SceneStorage
    // 앱을 종료한 다음에 만드는 Scene은 가장 마지막에 저장된 값을 가져온다.
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct About_Storage_Previews: PreviewProvider {
    static var previews: some View {
        About_Storage()
    }
}

extension Color: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else{
            self = .black
            return
        }

        do {
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(color)
        } catch {
            self = .black
        }
    }

    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()

        } catch {
            return ""
        }
    }
}
