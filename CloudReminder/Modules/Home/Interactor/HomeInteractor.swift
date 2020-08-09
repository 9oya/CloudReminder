//
//  HomeHomeInteractor.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import UIKit
import CoreData
import ColorCompatibility

class HomeInteractor: NSObject, HomeInteractorInput {

    weak var output: HomeInteractorOutput!
    
    var frc: NSFetchedResultsController<NotiGroupMO>!
    
    func initializeFRC() {
        frc = NotiGroupMOService.shared.getNotiGroupMOFRC()
        frc.delegate = self
    }

    // MARK: HomeInteractorInput
    func performFRC() {
        do {
            try frc.performFetch()
        } catch (let error as NSError) {
            print("\(error), \(error.userInfo)")
        }
    }
    
    func numberOfNotiGroups(section: Int) -> Int {
        guard let sections = frc?.sections else {
            return 0
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func notiGroupAt(indexPath: IndexPath) -> NotiGroupMO? {
        return frc.object(at: indexPath)
    }
    
    func configureNotiTableCell(cell: NotiTableCell, indexPath: IndexPath) {
        let notiGroupMO = notiGroupAt(indexPath: indexPath)!
        let notiGroupViewModel = NotiGroupViewModel(notiGroupMO: notiGroupMO)
        cell.guideLabel.text = notiGroupViewModel.title
        cell.titleLabel.text = notiGroupViewModel.content
        cell.subTitleLabel.text = "\(notiGroupViewModel.time) \(notiGroupViewModel.daysOfWeek)"
        if !notiGroupMO.isOn {
            cell.guideLabel.textColor = ColorCompatibility.systemGray3
            cell.titleLabel.textColor = ColorCompatibility.systemGray3
            cell.subTitleLabel.textColor = ColorCompatibility.systemGray3
        } else {
            cell.guideLabel.textColor = ColorCompatibility.label
            cell.titleLabel.textColor = ColorCompatibility.label
            cell.subTitleLabel.textColor = ColorCompatibility.label
        }
        cell.accessoryType = .disclosureIndicator
    }
}

extension HomeInteractor: NSFetchedResultsControllerDelegate {
    // MARK: NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        output.beginUpdateTalbeView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if newIndexPath != nil {
                syncNotifCenterWithCoreData()
                output.insertATableRow(indexPath: newIndexPath!)
            }
            break
        case .update:
            syncNotifCenterWithCoreData()
            output.reloadTableView()
            break
        case .delete:
            if indexPath != nil {
                syncNotifCenterWithCoreData()
                output.deleteATableRow(indexPath: indexPath!)
            }
            break
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        output.endUpdateTableView()
    }
}

extension HomeInteractor {
    private func syncNotifCenterWithCoreData() {
        let localNotiScheduler = LocalNotiScheduler()
        localNotiScheduler.fetchScheduledNotiRquests { (notiRequests) in
            if let notiMOArr = NotiMOService.shared.getAllNotiMOs() {
                let idArrFromNotifMO = notiMOArr.map { (notiMO) -> String in
                    return notiMO.id!.uuidString
                }
                
                print("Total number of notifications before process: \(notiRequests.count)")
                for notiRequest in notiRequests {
                    if !idArrFromNotifMO.contains(notiRequest.identifier) {
                        localNotiScheduler.removeNotification(id: notiRequest.identifier)
                    }
                }
                localNotiScheduler.notiMOArr = notiMOArr
                localNotiScheduler.schedule()
            }
        }
    }
}
