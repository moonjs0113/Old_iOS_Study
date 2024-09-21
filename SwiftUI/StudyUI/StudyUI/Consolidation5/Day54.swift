//
//  Day54.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/03/25.
//

import SwiftUI
import CoreData

struct Day54: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
        //        SortDescriptor(\.title, order: .reverse) // 반대로
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            self.moc.delete(book)
        }
        try? self.moc.save()
    }
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(self.books) { book in
                        NavigationLink {
                            DetailView(book: book)
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                VStack(alignment: .leading) {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }.onDelete(perform: self.deleteBooks)
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
                
            }
            .sheet(isPresented: self.$showingAddScreen) {
                AddBookView()
            }
        }
    }
}

struct EmojiRatingView: View {
    let rating: Int16
    var body: some View {
        switch self.rating {
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        default:
            Text("5")
        }
    }
}

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        return number > self.rating ? self.offImage ?? self.onImage : self.onImage
        //        if number > self.rating {
        //            return self.offImage ?? self.onImage
        //        } else {
        //            return self.onImage
        //        }
    }
    
    var body: some View {
        HStack {
            if self.label.isEmpty == false {
                Text(self.label)
            }
            
            ForEach(1..<self.maximumRating + 1, id: \.self) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
}

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @Environment(\.dismiss) var dismiss
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: self.$title)
                    TextField("Author's name", text: self.$author)
                    
                    Picker("Genre", selection: self.$genre) {
                        ForEach(self.genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: self.$review)
                    RatingView(rating: self.$rating)
                    //                Picker("Rating", selection: self.$rating) {
                    //                    ForEach(0..<6) { rating in
                    //                        Text(String(rating))
                    //                    }
                    //                }
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    func deleteBook() {
        self.moc.delete(self.book)
        self.dismiss()
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(self.book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(self.book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Text(self.book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(self.book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(self.book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(self.book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: self.$showingDeleteAlert) {
            Button("Delete", role: .destructive, action: self.deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                self.showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
}

struct Day54_Previews: PreviewProvider {
    static var previews: some View {
        Day54()
    }
}
