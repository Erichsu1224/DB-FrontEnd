//
//  ListPage.swift
//  Music Plus
//
//  Created by 劉品萱 on 2019/10/3.
//  Copyright © 2019 劉品萱. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct SongDownload: Decodable{
    let song_address: URL
}

class ListPage: UIViewController{
    
    
    @IBOutlet weak var PersonalListButton: UIButton!
    @IBOutlet weak var ThemeListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonalListButton.setTitleColor(UIColor.orange, for: .normal)
        PersonalListButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        //GetSongName()
        // Do any additional setup after loading the view.
    }
    
    var CenterPVC: ListPVC!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "ListPVCSegue")
        {
            if(segue.destination.isKind(of: ListPVC.self))
            {
                CenterPVC = segue.destination as? ListPVC
            }
        }
    }
    
    
    @IBAction func ListPageFirst(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 0)
        PersonalListButton.setTitleColor(UIColor.orange, for: .normal)
        PersonalListButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        ThemeListButton.setTitleColor(UIColor.white, for: .normal)
        ThemeListButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
    }
    
    @IBAction func ListPageSecond(_ sender: Any) {
        CenterPVC.setViewControllerFromIndex(index: 1)
        PersonalListButton.setTitleColor(UIColor.white, for: .normal)
        PersonalListButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        ThemeListButton.setTitleColor(UIColor.orange, for: .normal)
        ThemeListButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
    }
}


class ListPVCPersonal: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var MusicListSearchBar: UISearchBar!
    @IBOutlet weak var MusicListTableView: UITableView!
    
    var song:[String] = []
    var SongArray = [SONG]()
    var SongSearchArray = [SONG]()
    var audioPlayer2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicListTableView?.estimatedRowHeight = 0
        MusicListTableView?.delegate = self
        MusicListTableView?.dataSource = self
        SetUpSongs()
        SetUpSongSearch()
        GetSongName()
    }
    
    private func GetSongName()
    {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
     
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
     
            for song in songPath
            {
                var mySong = song.absoluteString
                if mySong.contains(".mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
     
                    if(loadcount < SongSearchArray.count)
                    {
                        songs.append(mySong)
                        loadcount+=1
                    }
     
     
                }
            }
     }
        catch
        {
     
        }
    }
    
    // Set up Songs Information
    private func SetUpSongs()
    {
        SongArray.append(SONG(Cover: "Red Moon", SongName: "Sleep in the car", Singer: "마마무", Category: .Korean))
        SongArray.append(SONG(Cover: "Red Moon", SongName: "Summer Night's Dream", Singer: "마마무", Category: .Korean))
        SongArray.append(SONG(Cover: "Red Moon", SongName: "Egotistic", Singer: "MAMAMOO", Category: .Korean))
     
        SongSearchArray = SongArray
    }
    
    private func SetUpSongSearch()
    {
        MusicListSearchBar?.delegate = self
    }

    
    // Table View Data Information
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
     // Declare Table View Cell Num
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongSearchArray.count
    }
     // Set Table View DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MusicListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SongsTableViewCell
     
        cell.CoverCell.image = UIImage(named: SongSearchArray[indexPath.row].Cover)
        cell.SongNameCell.text = SongSearchArray[indexPath.row].SongName
        cell.SingerCell.text = SongSearchArray[indexPath.row].Singer
     
        return cell
    }
     
     // Set Table View Cell high
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
     
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do
        {
            let parameters:[String:Any] = ["SongId": indexPath.row + 1] as! [String:Any]
            
            
            guard let url = URL(string: "http://140.136.149.239:3000/play") else {return}
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
            
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with:  request){
                (data, response, error) in
                if let response = response{
                    print(response)
                }
                
                if let data = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        
                        var json2 = try JSONDecoder().decode(SongDownload.self, from: data)
                        print("song_address", json2.song_address)
                        self.downloadFile(url: json2.song_address)
                        print(FileManager.default)
                        print(Bundle.main.resourcePath)
                    }
                    catch{
                        print(error)
                    }
                }
            }.resume()
        }
        catch
        {
            
        }
        
        
    }
    
    var audioPlayer = AVAudioPlayer()
    var songname = String()
    
    func downloadFile(url: URL) {
        let downloadRequest = URLRequest(url: url)
        URLSession.shared.downloadTask(with: downloadRequest) { location, response, error in
            // To do check resoponse before saving
            guard  let tempLocation = location, error == nil else { return }
            let documentDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
            do {
                let fullURL = try documentDirectory.appendingPathComponent((response?.suggestedFilename!)!)
                try FileManager.default.moveItem(at: tempLocation, to: fullURL)
                print("saved at \(fullURL) ")
                self.songname = fullURL.lastPathComponent
                print(self.songname)
                self.audioPlayer = try AVAudioPlayer(contentsOf: fullURL)
                self.audioPlayer.play()
            } catch CocoaError.fileReadNoSuchFileError {
                print("No such file")
            } catch {
                // other errors
                print("Error downloading file : \(error)")
            }
        }.resume()
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { SongSearchArray = SongArray; MusicListTableView.reloadData();  return }
     
        SongSearchArray =  SongArray.filter({song -> Bool in
        switch searchBar.selectedScopeButtonIndex{
            case 0:
                if searchText.isEmpty {return true}
                return song.SongName.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty {return song.Category == .Chinese}
                return song.SongName.lowercased().contains(searchText.lowercased()) && song.Category == .Chinese
            case 2:
                if searchText.isEmpty {return song.Category == .Korean}
                return song.SongName.lowercased().contains(searchText.lowercased()) && song.Category == .Korean
            case 3:
                if searchText.isEmpty {return song.Category == .Japanese}
                return song.SongName.lowercased().contains(searchText.lowercased()) && song.Category == .Japanese
            case 4:
                if searchText.isEmpty {return song.Category == .Western}
                return song.SongName.lowercased().contains(searchText.lowercased()) && song.Category == .Western
            default:
                return false
        }
     
    })
     
    MusicListTableView.reloadData()
    }
     
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope{
            case 0:
                SongSearchArray = SongArray
            case 1:
                SongSearchArray = SongArray.filter({song -> Bool in
                    song.Category == SongType.Chinese
                })
            case 2:
                SongSearchArray = SongArray.filter({song -> Bool in
                    song.Category == SongType.Korean
                })
            case 3:
                SongSearchArray = SongArray.filter({song -> Bool in
                    song.Category == SongType.Japanese
                })
            case 4:
                SongSearchArray = SongArray.filter({song -> Bool in
                    song.Category == SongType.Western
                })
            default:
                break
        }
        MusicListTableView.reloadData()
     }
}

class ListPVCTheme: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var ThemeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var ThemeNameArray:[UIImage] = [UIImage(named: "SportThemeIcon")!, UIImage(named: "RelaxThemeIcon")!, UIImage(named: "AutumnThemeIcon")!, UIImage(named: "FeelingThemeIcon")!, UIImage(named: "StudyThemeIcon")!, UIImage(named: "TimeMachineIcon")!]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ThemeNameArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ThemeListCollectionViewCell
        
        //cell.ThemeListButton.setTitle(ThemeNameArray[indexPath.row], for: .normal)
        cell.ThemeListButton.setImage(ThemeNameArray[indexPath.row], for: .normal)
        
        return cell
    }
    
    /*override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let padding: CGFloat = 60
        let collectionViewSize = ThemeCollectionView.frame.size.height - padding
        return CGSize(width: 20, height: 300)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->CGSize{
        let padding: CGFloat = 5
        let collectionViewSize = ThemeCollectionView.frame.size.width - padding
        return CGSize(width: 100, height: 300)
    }
    
}



class SONG {
    let Cover: String
    let SongName: String
    let Singer: String
    let Category: SongType
 
    init(Cover: String, SongName: String, Singer: String, Category: SongType)
    {
        self.Cover = Cover
        self.SongName = SongName
        self.Singer = Singer
        self.Category = Category
    }
}
 
enum SongType: String {
    case Chinese = "Chinese"  // 華語
    case Korean = "Korean"   // 韓語
    case Japanese = "Japanese" // 日語
    case Western = "Western"  // 西洋
}
