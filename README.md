<p align="center">

<img src="./Logo/Logo.png"/>

</p>


 [![Version](https://img.shields.io/cocoapods/v/MDTable.svg?style=flat)](http://cocoapods.org/pods/MDTable)  [![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
 [![Language](https://img.shields.io/badge/language-swift%203.0-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
 [![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

## MDTables

MDTable is a *data-driven UITableView**.

```
let row0 = Row(title: "System Cell", accessoryType: .disclosureIndicator)
row0.onDidSelected { (tableView, indexPath) in
    tableView.deselectRow(at: indexPath, animated: true)
}
let row1 = Row(title: "Custom Cell", accessoryType: .disclosureIndicator)
    
let section0 = Section(rows: [row0,row1])
section0.titleForHeader = "Basic"
section0.heightForHeader = 30.0
    
tableView.manager = TableManager(sections: [section0])
```

And your tableView is ready.

<img src="./Screenshot/MainList.png" width="320">

- [中文文档](https://github.com/LeoMobileDeveloper/MDTable/blob/master/Documents/Chinese%20Document.md)

## Demo
The example project contains a demo of **NeteaseCloudMusic**。(以网易云音乐首页作为Demo)

<img src="https://raw.githubusercontent.com/LeoMobileDeveloper/React-Native-Files/master/Demo.gif" width="320">

- [实现60fps的网易云音乐首页](http://www.jianshu.com/p/dcf010d419ec)


## Require

- Xcode 8.1+
- iOS 8.0+ 
- Swift 3.0+

## Install

### CocoaPod

```
pod "MDTable"
```

### Carthage

```
github "LeoMobileDeveloper/MDTable"
```

## Useage

### Basic concept

MDTable offers tow basic types:

- `Row` - model of Cell.
- `Section`- model of Section


You create rows and sections.

```
let row = Row(title: "System Cell", accessoryType: .disclosureIndicator)
let section0 = Section(rows: row)
```

Then use declarative API to handle event

```
row.onWillDisplay { (tableView, cell, indexPath) in
    //Access manager with tableView.manager
}
row.onDidSelected { (tableView, indexPath) in
    
}
```
Then,create a manager and bind to tableView

```
tableManager = TableManager(sections: [section0])
tableView.md_bindTo(manager: tableManager)
```

### Custom Cell

#### Model

Create a subClass of `ReactiveRow`

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

#### Cell

Create a subclass of `MDTableViewCell`,and override `render`

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

#### Magic happens

```
let row = XibRow(title: "Title", subTitle: "Subtitle", image: UIImage(named: "avatar")!)
row.onDidSelected({ (tableView, indexPath) in
    tableView.manager?.delete(row: indexPath)
    tableView.deleteRows(at: [indexPath], with: .automatic)
})
let section = Section(rows: rows)
section.heightForHeader = 30.0
section.titleForHeader = "Tap Row to Delete"
tableView.manager = TableManager(sections: [section])
```

## Note

You need to use `[unowned self]` to avoid retain circle

```
row.onDidSelected = { [unowned self] (tableView, indexPath) in
}
```

## Author

Leo, leomobiledeveloper@gmail.com

## License

MDTable is available under the MIT license. See the LICENSE file for more info.
