## 为什么选择MDTable

MDTable是一个模型驱动的响应式框架，使用MDTable，开发者不需要关注复杂的Delegate/DataSource方法。MDTable只关注三件事情

- Row - 用来表示每一行的模型。你可以选择继承
- SectionModel - 实现`TableSection`协议的实例，用来表示每一个Section。
- Cell - MDTableViewCell及其子类，用来表示每一行如何展示。

在使用MDTable的时候，开发者只需要

- 根据数据生成RowModel和SectionModel
- 根据Row和Section创建Manager
- 把Manager绑定到TableView。

```
//创建Row
let row0_0 = SystemRow(title: "System Cell", accessoryType: .disclosureIndicator)
let row0_1 = SystemRow(title: "Custom Cell", accessoryType: .disclosureIndicator)
//创建Section
let section0 = SystemSection(rows: [row0_0,row0_1]])
section0.titleForHeader = "Basic"
section0.heightForHeader = 30.0
//创建Manager
tableView.manager = TableManager(sections: [section0,section1])
```

----
## Cell

为了能够让子类重写，MDTable提供了`MDTableViewCell`（对`UITableViewCell`的简单封装）。并且提供了类`Row`来表示`SystemTableViewCell`对应的Model。

- image 
- title 
- detailTitle  
- accessoryType
- rowHeight
- cellStyle 
- reuseIdentifier 复用标识符
- initalType 初始化类型（通过xib/还是代码）

----
## 事件

MDTable采用响应式的API来进行事件回调：

```
row.onWillDisplay { (tableView, cell, indexPath) in
    //Access manager with tableView.manager
}
row.onDidSelected { (tableView, indexPath) in
    
}
```

---
## 自定义Cell

自定义Cell，你需要以下两个步骤：

### 创建Model类

创建一个类型，继承`ReactiveRow`

```
class XibRow:ReactiveRow{
    //Data
    var title:String
    var subTitle:String
    var image:UIImage
    init(title:String, subTitle:String, image:UIImage) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        super.init()
        self.rowHeight = 80.0
        self.reuseIdentifier = "XibRow"
        self.initalType = RowConvertableInitalType.xib(xibName: "CusomCellWithXib")
    }
}
```

### 创建MDTableViewCell的子类

可以用XIB，或者Class。只要与RowModel的`initalType`一致即可。然后，重写Render方法

```
class CusomCellWithXib: MDTableViewCell{    
    override func render(with row: TableRow) {
        guard let row = row as? XibRow else{
            return;
        }
        //Render the cell 
    }
}
```
接着，在Controller中，使用RowModel即可：

```
import MDTable

class CustomCellWithXibController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Custom cell with XIB"
        let rows = (1..<100).map { (index) -> CustomXibRow in
            let row = CustomXibRow(title: "Title\(index)", subTitle: "Subtitle \(index)", image: UIImage(named: "avatar")!)
            row.didSelectRowAt = { (tableView, indexPath) in
                tableView.manager.delete(row: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return row
        }
        let section = SystemSection(rows: rows)
        section.heightForHeader = 30.0
        section.titleForHeader = "Tap Row to Delete"
        tableView.manager = TableManager(sections: [section])
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
class SwipteToDeleteRow: ReactiveRow, EditableRow{
    var titleForDeleteConfirmationButton: String? = "Delete"
    var editingStyle:UITableViewCellEditingStyle = .delete
}
```

MDTable提供了`Editor`(协议)来处理编辑相关的逻辑，并且提供了一个默认的`TableEditor`

比如，最简单的滑动删除

```
let rows = (1..<100).map { (index) -> SwipteToDeleteRow in
    let row = SwipteToDeleteRow(title: "\(index)")
    return row
}
let section = Section(rows: rows)
section.heightForHeader = 30.0
section.titleForHeader = "Swipe to Delete"
let tableEditor = TableEditor()
tableEditor.editingStyleCommitForRowAt = { (tableView, style, indexPath) in
    if style == .delete{
        tableView.manager.delete(row: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
tableView.manager = TableManager(sections: [section],editor:tableEditor)
```

---
## 排序

排序也在EditableRow协议中

```
class ReorderRow: ReactiveRow, EditableRow{
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
let section = Section(rows: rows)
section.heightForHeader = 0.0
let tableEditor = TableEditor()
tableEditor.moveRowAtSourceIndexPathToDestinationIndexPath = { (tableview,sourceIndexPath,destinationIndexPath) in
    tableview.manager.exchange(sourceIndexPath, with: destinationIndexPath)
}
tableView.manager = TableManager(sections: [section],editor:tableEditor)
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