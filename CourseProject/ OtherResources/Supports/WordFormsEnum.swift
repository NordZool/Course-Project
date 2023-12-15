



enum WordFormsEnum : String, CaseIterable, Hashable {
    case pref = "Приставка"
    case rt = "Корень"
    case suf = "Суффикс"
    case postf = "Окончание"
    
    var next: WordFormsEnum {
        switch self {
        case .pref:
                .rt
        case .rt:
                .suf
        case .suf:
                .postf
        case .postf:
            //некуда переходить
            //после окончания
                .postf
        }
    }
}
