import UIKit
import Action
import NSObject_Rx
import RxCocoa
import RxSwift

public func applyWeakly<T>(_ instance: T, _ function: @escaping (T) -> () -> ())
    -> () -> () where T: AnyObject
{
    return { [weak instance] in
        guard let instance = instance else { return }
        function(instance)()
    }
}

public func applyWeakly<T, A>(_ instance: T, _ function: @escaping (T) -> (A) -> ())
    -> (A) -> () where T: AnyObject
{
    return { [weak instance] a in
        guard let instance = instance else { return }
        function(instance)(a)
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    public var viewModel: ViewControllerViewModelType = ViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.version.subscribe(
            onNext: { print("version is \($0.code)" ) }
        ).disposed(by: rx.disposeBag)

        button.rx.bind(to: viewModel.refresh, input: ("2.5.0", 2))
        viewModel.refresh.underlyingError.bind(to: view.rx.networkError).disposed(by: rx.disposeBag)
        
//        viewModel.dataSouce.bind(
//            to: UITableView().rx.items(cellIdentifier: "123", cellType: UITableViewCell.self)
//        ) { (row, elememt, cell) in
//            cell.textLabel?.text = "\(row) --> \(elememt)"
//        }.disposed(by: rx.disposeBag)
        
    }
}
