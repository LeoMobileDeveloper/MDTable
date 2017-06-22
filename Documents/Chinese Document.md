## 为什么选择MDTable

MDTable是一个模型驱动的框架，使用MDTable，开发者不需要关注复杂的Delegate/DataSource方法。MDTable只关注三件事情

- RowModel - 实现`TableRow`协议的实例，用来表示每一行Cell
- SectionModel - 实现`TableSection`协议的实例，用来表示每一个Section。
- Cell - SystemTableViewCell及其子类，用来表示每一行如何展示。

在使用MDTable的时候，开发者只需要

- 根据数据生成RowModel和SectionModel
- 根据Row和Section创建TableManager
- 把TableManager绑定到TableView。

```
//创建Row
let row0_0 = SystemRow(title: "System Cell", accessoryType: .disclosureIndicator)
let row0_1 = SystemRow(title: "Custom Cell", accessoryType: .disclosureIndicator)
//创建Section
let section0 = SystemSection(rows: [row0_0,row0_1]])
section0.titleForHeader = "Basic"
section0.heightForHeader = 30.0
//创建TableManager
tableManager = TableManager(sections: [section0,section1])
//绑定到TableView
tableView.md_bindTo(manager: tableManager)
```

----
## UITableViewCell

为了能够让子类重写，MDTable提供了`SystemTableViewCell`（对`UITableViewCell`的简单封装）。并且提供了数据结构`class SystemRow`来表示`SystemTableViewCell`对应的Model。

SystemRow有如下属性（完全和UITableViewCell一样）

- image 
- title 
- detailTitle  
- accessoryType
- rowHeight
- cellStyle 
- reuseIdentifier 复用标识符
- initalType 初始化类型（通过xib/还是代码）

并且，SystemRow提供了三个方便的方法

```
//在每一行重新渲染的时候调用，其中isInital表示这个Cell是否是第一次创建并添加到复用池里
func onRender(_ action:@escaping (_ cell: UITableViewCell,_ isInital: Bool)->Void)->SystemRow

//didSelected事件
func onDidSelected(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)->SystemRow{
        self._didSelect = action
        return self
    }
    
//accessoryButton点击事件
func onAccessoryButtonTapped(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)->SystemRow

```
这些事件支持链式调用：

```
let row1 = SystemRow(title: "Custom Color", rowHeight: 40.0, accessoryType: .detailDisclosureButton)
row1.onRender { (cell,isInital) in
    cell.textLabel?.textColor = UIColor.orange
    cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
}.onDidSelected { (tableView, indexPath) in
    tableView.deselectRow(at: indexPath, animated: true)
}
```
---
## 自定义Cell
通畅自定义Cell，你需要以下两个步骤：

### 创建RowModel

创建一个类型，并且实现协议`TableRow`

```
class CustomXibRow: TableRow{
    var rowHeight: CGFloat = 80.0
    var reuseIdentifier: String = "CustomXibRow"
    var initalType: TableRowInitalType = TableRowInitalType.xib(xibName: "CusomCellWithXib")
    //事件
    var didSelectRowAt: (UITableView, IndexPath) -> Void
    
    //数据
    var title:String
    var subTitle:String
    var image:UIImage
    init(title:String, subTitle:String, image:UIImage) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.didSelectRowAt = {_,_ in}
    }

}
```

其中，TableRow有三个必须要提供的属性：

- `rowHeight: CGFloat` 行高
- `reuseIdentifier: String` 复用标识符
- `initalType: TableRowInitalType` 初始化类型

### 创建SystemTableViewCell的子类

可以用XIB，或者Class。只要与RowModel的`initalType`一致即可。然后，重写Render方法

```
class CusomCellWithXib: SystemTableViewCell{

    @IBOutlet weak var customSubTitleLabel: UILabel!
    @IBOutlet weak var customTitleLabel: UILabel!
    @IBOutlet weak var avaterImageView: UIImageView!
    
    override func render(with row: TableRow) {
        guard let row = row as? CustomXibRow else{
            return;
        }
        customTitleLabel.text = row.title
        customSubTitleLabel.text = row.subTitle
        avaterImageView.image = row.image
    }
}

```
接着，在Controller中，使用RowModel即可：

```
import MDTable

class CustomCellWithXibController: UITableViewController {
    var tableManager:TableManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Custom cell with XIB"
        let rows = (1..<100).map { (index) -> CustomXibRow in
            let row = CustomXibRow(title: "Title\(index)", subTitle: "Subtitle \(index)", image: UIImage(named: "avatar")!)
            row.didSelectRowAt = { (tableView, indexPath) in
                self.tableManager.delete(row: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return row
        }
        let section = SystemSection(rows: rows)
        section.heightForHeader = 30.0
        section.titleForHeader = "Tap Row to Delete"
        tableManager = TableManager(sections: [section])
        tableView.md_bindTo(manager: tableManager)
    }
}

```

---
## 动态行高

由于行高是在RowModel里提供的，所以你需要在这里动态计算行高

```
   var rowHeight: CGFloat{
        get{
            let attributes = [NSFontAttributeName: CustomCellWithCodeConfig.font]
            let size = CGSize(width: CustomCellWithCodeConfig.cellWidth, height: .greatestFiniteMagnitude)
            let height = (self.title as NSString).boundingRect(with: size,
                                                               options: [.usesLineFragmentOrigin],
                                                               attributes: attributes,
                                                               context: nil).size.height
            return height + 8.0
        }
    }
```

由于是模型驱动的，你可以对行高进行缓存或者预计算来让UI更丝滑。

---
## 编辑

如果某一行支持编辑，那么它需要实现协议`EditableRow`

```
class SwipteToDeleteRow: SystemRow, EditableRow{
    var titleForDeleteConfirmationButton: String? = "Delete"
    var editingStyle:UITableViewCellEditingStyle = .delete
}
```
MDTable提供了`TableEditor`(协议)来处理编辑相关的逻辑，并且提供了一个默认的`SystemTableEditor`

比如，最简单的滑动删除

```
let rows = (1..<100).map { (index) -> SwipteToDeleteRow in
            let row = SwipteToDeleteRow(title: "\(index)")
            return row
}
let section = SystemSection(rows: rows)
section.heightForHeader = 30.0
section.titleForHeader = "Swipe to Delete"

let tableEditor = SystemTableEditor()
tableEditor.editingStyleCommitForRowAt = { (tableView, style, indexPath) in
    if style == .delete{
        self.tableManager.delete(row: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

tableManager = TableManager(sections: [section],editor:tableEditor)
tableView.md_bindTo(manager: tableManager)
```

---
## 排序

排序也在EditableRow协议中

```
class ReorderRow: SystemRow, EditableRow{
    var titleForDeleteConfirmationButton: String? = nil
    var editingStyle:UITableViewCellEditingStyle = .none
    var canMove: Bool = true
    var shouldIndentWhileEditing: Bool = false
}
```

同样，你需要创建一个TableEditor，来管理排序相关的逻辑：

```
tableView.setEditing(true, animated: false)
let rows = (1..<100).map { (index) -> ReorderRow in
    let row = ReorderRow(title: "\(index)")
    return row
}
let section = SystemSection(rows: rows)
section.heightForHeader = 0.0
let tableEditor = SystemTableEditor()
tableEditor.moveRowAtSourceIndexPathToDestinationIndexPath = { (tableview,sourceIndexPath,destinationIndexPath) in
    self.tableManager.exchange(sourceIndexPath, with: destinationIndexPath)
}
tableManager = TableManager(sections: [section],editor:tableEditor)
tableView.md_bindTo(manager: tableManager)
```

---
## Index Title

IndexTitle的实现非常容易，只需要配置Section的`sectionIndexTitle`属性即可

```
section.sectionIndexTitle = "A"
```


---
## TODO:

- 支持Menu
- 支持Focus