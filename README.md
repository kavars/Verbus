# Verbus
Small application for learning irregular verbs
Based on VIPER architecture

## Instruments stack:
* UIKit & Foundation:
    - Calendar;
    - UserDefaults;
    - UINotificationFeedbackGenerator;
    - UITableView & UICollectionView;
    - Custom views.
* CoreData:
    - NSFetchedResultsController;
    - NSPredicate & NSSortDescriptor;
    - NSBatchUpdate.
* AVFoundation:
    - AVSpeechSynthesizer.
* UserNotifications.

### First start

I can't load .sql files on github

For generate DB with verbs
1. Open "Services/Store Service/StoreVerbsService.swift"
2. Uncomment line 87
3. Comment line 57
4. Build & Run app

After that you can find .sql files in ~/Library/Developer/CoreSimulator/Devices/"device-name"/data/Containers/Data/Application/"app-name"/Library/Application Support/
And add to project

For use .sql DB
1. Open "Services/Store Service/StoreVerbsService.swift"
2. Comment line 87
3. Uncomment line 57
4. Build & Run app
