//
//  IconPickerView.swift
//  PersonalBudgetManager
//
//  Created by user271720 on 5/18/25.
//

import SwiftUI

struct IconPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedIcon: String
    @State private var searchText = ""
    
    //Common SF Symbols for categories
    
    let icons = [
        "house.fill", "car.fill", "bus.fill", "tram.fill", "airplane", "cart.fill",
        "bag.fill", "creditcard.fill", "dollarsign.circle.fill", "giftcard.fill",
        "gift.fill", "fork.knife", "cup.and.saucer.fill", "wineglass.fill",
        "takeoutbag.and.cup.and.straw.fill", "popcorn.fill", "ticket.fill",
        "tv.fill", "gamecontroller.fill", "headphones", "book.fill",
        "graduationcap.fill", "backpack.fill", "cross.fill", "pills.fill",
        "heart.fill", "stethoscope", "figure.run", "dumbbell.fill",
        "sportscourt.fill", "basketball.fill", "figure.skiing.downhill",
        "figure.hiking", "figure.outdoor.cycle", "figure.pool.swim",
        "figure.tennis", "figure.yoga", "figure.handball", "figure.badminton",
        "figure.bowling", "figure.boxing", "figure.dance", "figure.golf",
        "figure.hockey", "figure.lacrosse", "figure.socialdance", "figure.volleyball",
        "figure.waterpolo", "figure.wrestling", "figure.cooldown", "figure.strengthtraining.traditional",
        "scissors", "hammer.fill", "wrench.fill", "screwdriver.fill",
        "paintbrush.fill", "printer.fill", "briefcase.fill", "building.2.fill",
        "building.columns.fill", "bed.double.fill", "sofa.fill", "chair.fill",
        "table.furniture", "lamp.desk.fill", "washer.fill", "oven.fill",
        "refrigerator.fill", "shower.fill", "bathtub.fill", "toilet.fill",
        "sink.fill", "lightbulb.fill", "fan.fill", "wifi", "network",
        "phone.fill", "envelope.fill", "paperplane.fill", "calendar",
        "clock.fill", "alarm.fill", "stopwatch.fill", "timer",
        "sun.max.fill", "moon.fill", "cloud.fill", "cloud.rain.fill",
        "cloud.snow.fill", "bolt.fill", "leaf.fill", "tree.fill",
        "pawprint.fill", "tortoise.fill", "hare.fill", "ant.fill",
        "ladybug.fill", "fish.fill", "bird.fill", "lizard.fill",
        "dog.fill", "cat.fill", "camera.fill", "photo.fill",
        "film.fill", "music.note", "mic.fill", "guitars.fill",
        "pianokeys", "speaker.wave.3.fill", "radio.fill", "person.fill",
        "person.2.fill", "person.3.fill", "figure.child", "figure.dress.line.vertical.figure",
        "figure.and.child.holdinghands", "figure.2.and.child.holdinghands", "heart.text.square.fill",
        "bubble.left.fill", "star.fill", "flag.fill", "location.fill",
        "mappin.and.ellipse", "globe", "airplane.circle.fill", "car.circle.fill",
        "tram.circle.fill", "bus.doubledecker.fill", "ferry.fill", "bicycle.circle.fill",
        "scooter", "fuelpump.fill", "drop.fill", "flame.fill",
        "bolt.car.fill", "trash.fill", "folder.fill", "archivebox.fill",
        "doc.fill", "newspaper.fill", "magazine.fill", "books.vertical.fill",
        "pencil", "highlighter", "ruler.fill", "scissors",
        "paperclip", "link", "lock.fill", "key.fill",
        "pin.fill", "map.fill", "scissors", "eyeglasses",
        "facemask.fill", "brain.head.profile", "bandage.fill", "cross.case.fill",
        "syringe.fill", "pill.fill", "ivfluid.bag.fill", "waveform.path.ecg",
        "allergens", "ear", "eye.fill", "nose.fill",
        "mustache.fill", "mouth.fill", "hand.raised.fill", "hand.thumbsup.fill",
        "hand.thumbsdown.fill", "hand.point.up.left.fill", "hand.tap.fill", "hand.wave.fill",
        "hands.clap.fill", "hands.sparkles.fill", "crown.fill", "trophy.fill",
        "medal.fill", "rosette", "flag.checkered", "flag.filled.and.flag.crossed",
        "flag.2.crossed.fill", "flag.and.flag.filled.crossed", "bell.fill", "bell.and.waveform.fill",
        "megaphone.fill", "speaker.fill", "music.mic", "music.quarternote.3",
        "guitars", "pianokeys", "dial.min.fill", "dial.max.fill",
        "gauge.with.dots.needle.bottom.50percent", "gauge.with.needle", "speedometer", "barometer",
        "metronome.fill", "tuningfork", "paintpalette.fill", "paintbrush.pointed.fill",
        "lasso", "trash.slash.fill", "folder.badge.plus", "tray.full.fill",
        "externaldrive.fill", "archivebox.circle.fill", "xmark.bin.fill", "checkmark.seal.fill",
        "checkmark.circle.fill", "xmark.circle.fill", "exclamationmark.circle.fill", "questionmark.circle.fill",
        "plus.circle.fill", "minus.circle.fill", "ellipsis.circle.fill", "arrow.up.circle.fill",
        "arrow.down.circle.fill", "arrow.left.circle.fill", "arrow.right.circle.fill",
        "arrow.up.arrow.down.circle.fill","arrow.left.arrow.right.circle.fill","arrow.triangle.2.circlepath.circle.fill",
        "arrow.clockwise.circle.fill","arrow.counterclockwise.circle.fill"
    ]
    
    var filteredIcons: [String] {
        if searchText.isEmpty {
            return icons
        } else {
            return icons.filter { $0.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var body: some View {
           NavigationStack {
               VStack {
                   // Search bar
                   TextField("Search icons", text: $searchText)
                       .padding()
                       .background(Color(.systemGray6))
                       .cornerRadius(10)
                       .padding(.horizontal)
                       .padding(.top)
                   
                   // Icon grid
                   ScrollView {
                       LazyVGrid(columns: [
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())
                       ], spacing: 20) {
                           ForEach(filteredIcons, id: \.self) { icon in
                               Button(action: {
                                   selectedIcon = icon
                                   dismiss()
                               }) {
                                   VStack {
                                       Image(systemName: icon)
                                           .font(.system(size: 24))
                                           .frame(width: 50, height: 50)
                                           .background(selectedIcon == icon ? Color.blue.opacity(0.3) : Color.clear)
                                           .cornerRadius(8)
                                       
                                       Text(icon.split(separator: ".").first?.description ?? icon)
                                           .font(.system(size: 8))
                                           .lineLimit(1)
                                           .truncationMode(.tail)
                                   }
                               }
                               .foregroundColor(selectedIcon == icon ? .blue : .primary)
                           }
                       }
                       .padding()
                   }
               }
               .navigationBarTitle("Select Icon", displayMode: .inline)
               .navigationBarItems(trailing: Button("Cancel") {
                   dismiss()
               })
           }
       }
   }
