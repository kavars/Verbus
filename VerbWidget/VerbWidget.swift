//
//  VerbWidget.swift
//  VerbWidget
//
//  Created by Kirill Varshamov on 09.12.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import WidgetKit
import SwiftUI

let snapshotEntry = SimpleEntry(date: Date(), infinitive: "do", pastSimple: "did", pastParticiple: "done", translation: "делать")

struct Provider: TimelineProvider {
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        return snapshotEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(snapshotEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let coreDataService = StoreVerbsService(modelName: "Curb_your_Verb")
        
        let verbsOnLearning = coreDataService.verbsFetch(of: .all)
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            var entry = snapshotEntry
                        
            if let results = verbsOnLearning {
                let verb = results[Int.random(in: 0..<results.count)]

                if let infinitive = verb.infinitive, let pastSimple = verb.pastSimple, let pastParticiple = verb.pastParticiple, let translation = verb.translation {
                    
                    entry = SimpleEntry(date: entryDate, infinitive: infinitive, pastSimple: pastSimple, pastParticiple: pastParticiple, translation: translation)
                }
            }
            
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let infinitive: String
    let pastSimple: String
    let pastParticiple: String
    let translation: String
}

struct VerbWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        VStack(spacing: 10) {
            VStack(alignment: .center) {
                Text(entry.infinitive)
                    .font(Font.system(size: 25))
                Text(entry.pastSimple)
                    .font(Font.system(size: 25))
                Text(entry.pastParticiple)
                    .font(Font.system(size: 25))
                
            }
            VStack(alignment: .center) {
                Text(entry.translation)
                    .font(Font.system(size: 15))
            }

        }
        .frame(width: 330, height: 155, alignment: .center)
        .foregroundColor(Color(.sRGB, red: 0.639, green: 0.212, blue: 0.173, opacity: 1.0))
        .background(Color.init(.sRGB, red: 0.953, green: 0.898, blue: 0.682, opacity: 1.0))
    }
}

@main
struct VerbWidget: Widget {
    let kind: String = "VerbWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            VerbWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Verbus")
        .description("Напоминатель глаголов на вашем экране")
        .supportedFamilies([.systemMedium])
    }
}

struct VerbWidget_Previews: PreviewProvider {
    static var previews: some View {
        VerbWidgetEntryView(entry: snapshotEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
