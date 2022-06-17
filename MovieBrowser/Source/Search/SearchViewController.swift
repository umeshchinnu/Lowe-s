//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

// MARK: - Cell Identifiers
enum TableviewCellIdentifiers: String {
    case moviesListCell = "MoviesListTableViewCell"
}
// MARK: - Screen Titles
enum ScreenTitles: String {
    case moviesListTitle = "Movie Search"
}
// MARK: - Scenes Identifiers
enum StoryBoardScenesIdentifiers: String {
    case detailsVC = "MovieDetailViewController"
}
// MARK: - App APIs
enum MoviesAPIS: String {
    case moviesListAPI = "https://api.themoviedb.org/3/search/movie"
    case movieDetailsAPI = "https://api.themoviedb.org/3/getting-started/images"
}
class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewMoviesList: UITableView!
    var searchtext = ""
    var searchAry = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    func setupUI() {
        searchBar.delegate = self
        tableViewMoviesList.showsVerticalScrollIndicator = false
        // Register nib files
        tableViewMoviesList.register(UINib(nibName: TableviewCellIdentifiers.moviesListCell.rawValue, bundle: nil), forCellReuseIdentifier: TableviewCellIdentifiers.moviesListCell.rawValue)
        self.updateNavigationbarColor()
    }
    @IBAction func goForSearch(_ sender: UIButton) {
        loadMoviesList()
    }
    func loadMoviesList() {
        var params = [String:Any]()
        params.updateValue(Network.shared.apiKey, forKey: "api_key")
        params.updateValue(searchtext, forKey: "query")
        params.updateValue("en-US", forKey: "language")
        params.updateValue("1", forKey: "page")
        
        var urlComp = URLComponents(string: MoviesAPIS.moviesListAPI.rawValue)!
        urlComp.queryItems = [
            URLQueryItem(name: "api_key", value: Network.shared.apiKey),
            URLQueryItem(name: "query", value: searchtext),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        urlComp.percentEncodedQuery = urlComp.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest.init(url: urlComp.url!)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            //handle response here
            let decoder = JSONDecoder()
            do {
                let json: MoviesModel = try! decoder.decode(MoviesModel.self, from: data!)
                self.searchAry = json.results
                DispatchQueue.main.async {
                self.tableViewMoviesList.reloadData()
                }
            }
        }
        dataTask.resume()
    }
    
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableviewCellIdentifiers.moviesListCell.rawValue, for: indexPath) as! MoviesListTableViewCell
        cell.movie = searchAry[indexPath.row]
        return cell
    }
    
    
}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: StoryBoardScenesIdentifiers.detailsVC.rawValue) as! MovieDetailViewController
        vc.movie = searchAry[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension UIViewController {
    func updateNavigationbarColor() {
        if #available(iOS 15, *) {
            // Navigation Bar background color
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
            
            // setup title font color
            let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = titleAttribute
            self.title = ScreenTitles.moviesListTitle.rawValue
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchtext = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchtext = searchBar.text ?? ""
    }
}
