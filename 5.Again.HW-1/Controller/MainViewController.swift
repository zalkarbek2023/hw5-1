//
//  MainViewController.swift
//  5.Again.HW-1
//
//  Created by zalkarbek on 8/3/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var filteredTableView = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewDataArray()
        configureData()
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.tableViewCellReuseID, for: indexPath) as? MainTableViewCell else { fatalError() }
        let product = filteredTableView[indexPath.row]
        cell.displayInfo(product)
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filteredTableView[indexPath.row])
    }
}

extension MainViewController {
    
    private func configureData() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil), forCellReuseIdentifier: MainTableViewCell.tableViewCellReuseID)
    }
    
    private func configureTableViewDataArray()  {
        Task {
            do {
                let result = try await NetworkLayer.shared.fetchingAPIData().products
                DispatchQueue.main.async {
                    self.filteredTableView = result
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
