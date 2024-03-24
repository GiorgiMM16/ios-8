import Foundation

/* მადლობა საინტერესო დავალებისთვის <33 */


/* შევქმნათ Class Book.
 Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
 Designated Init.
 Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
 Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს 
*/

class Book {
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    func isBookPresent(isBorrowed: Bool) -> String {
        if isBorrowed == true {
            return("This book is borrowed")
        } else {
            return("This book is returned")
        }
    }
}

/* შევქმნათ Class Owner
 Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
 Designated Init.
 Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
 Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.
*/

class owner {
    var ownerID: Int
    var name: String
    var borrowedBooks: Array<Book>
    var libraryBooks: Array<Book>
    
    
    init(ownerID: Int, name: String, borrowedBooks: Array<Book>, libraryBooks: Array<Book>) {
        self.ownerID = ownerID
        self.name = name
        self.borrowedBooks = borrowedBooks
        self.libraryBooks = libraryBooks
    }

    
    func getABook(wigni1: Book, wantToGet: Bool) -> String {
        for (index, book) in libraryBooks.enumerated() {
            if book.title == wigni1.title && wantToGet {
                libraryBooks.remove(at: index)
                borrowedBooks.append(book)
                return "წიგნი აღებულია"
            }
        }
        return "არ გვაქვს მოცემული წიგნი ამჟამად"
    }
    
    /* ამ enumerated -მა გამაწვალა რასაც ქვია რაა*/
    
    func returnABook(whichBook: Book, wantToReturn: Bool) -> String{
        for (index, book) in borrowedBooks.enumerated() {
            if book.title == whichBook.title && wantToReturn {
                borrowedBooks.remove(at: index)
                return "წიგნი დაბრუნებულია"
            }
        }
        return "წიგნი ვერა ვიპოვეთ რა"
    }
    
}


/* შევქმნათ Class Library
 
 Properties: Books Array, Owners Array
 Designated Init
 Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით
 Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს
 Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს
 Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს
 Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს
 Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ
 Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია
 */

class library {
    var libraryBooks: Array<Book>
    var owners: Array<owner>
    var booksNotYetInTheLibrary: Array<Book>
    
    init(libraryBooks: Array<Book>, owners: Array<owner>, booksNotYetInTheLibrary: Array<Book>) {
        self.libraryBooks = libraryBooks
        self.owners = owners
        self.booksNotYetInTheLibrary = booksNotYetInTheLibrary
    }
    
    func addAbook(whichBook1: Book, wantToAddInLibrary: Bool) -> String {
        for (index, book) in booksNotYetInTheLibrary.enumerated() {
            if book.title == whichBook1.title && wantToAddInLibrary {
                booksNotYetInTheLibrary.remove(at: index)
                libraryBooks.append(book)
                return "წიგნი წარმატებით შემოუერთდა ჩვენი ბიბლიოთეკის არაჩვეულებრივ კოლექციას"
            }
        }
        return "წიგნი ვერ დაემატა ბიბლიოთეკას"
    }
    
    func addOwner(newOwner: owner, wantToAddOwner: Bool) -> String {
        if wantToAddOwner == true {
            owners.append(newOwner)
            return "ახალი owner წარმატებით დაემატა ბიბლიოთეკას"
        }
        return "ვერ დაემატა ბიბლიოთეკას"
    }
    
    func whichBooksInLibrary () -> Array<Book> {
        return libraryBooks
    }
    
    func whichBooksBorrowed () -> Array<Book> {
        return libraryBooks.filter({ $0.isBorrowed })
    }
    func lookForOwner (idOfOwner: owner) -> String {
        for idOfOwner1 in owners {
            if idOfOwner1.ownerID == idOfOwner.ownerID {
                return "ასეთი owner არის ბაზაში"
            }
        }
        return "ასეთი owner არ არის ბაზაში"
    }
    func whatBooksOwnerHas(owneriko: owner) -> String {
        var ownedBooks: [Book] = []
        for book in libraryBooks {
            if owneriko.borrowedBooks.contains(where: { $0.title == book.title }) {
                print(ownedBooks)
            }
        }
        return "ამ ოვნერიკოს არ აქვს გატანილი წიგნები"
    }
    
    func canOwnerHaveIt (owneriko1: owner, wigniko: Book) -> String {
        if libraryBooks.contains(where: { $0.title == wigniko.title}){
            for (index, book3) in libraryBooks.enumerated(){
                libraryBooks.remove(at: index)
                owneriko1.borrowedBooks.append(book3)
                }
            return "შეგიძლია წაიღო წიგნი"
        }
        return "წიგნი არ არის თავისუფალი"
    }
   
}


/* გავაკეთოთ ბიბლიოთეკის სიმულაცია.
 
 შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.
 დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში
 წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.
 დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და
 გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ */

/* ესეც ჩვენი წიგნები */
var danashauliDasSasjeli = Book(bookID: 1, title: "დანაშაული და სასჯელი", author: "დოსტოევსკი", isBorrowed: false)
var ostatiDaMargarita = Book(bookID: 2, title: "ოსტატი და მარგარიტა", author: "მიხაილ ბულგაკოვი", isBorrowed: true)
var kafkaPliajze = Book(bookID: 3, title: "კაფკა პლაჟზე", author: "ჰარუკი მურაკამი", isBorrowed: true)
var norvegiuliTye = Book(bookID: 4, title: "ნორვეგიული ტყე", author: "ჰარუკი მურაკამი", isBorrowed: false)

/* ესეც ჩვენი ოუნერები */

var soso = owner(ownerID: 2001, name: "სოსო", borrowedBooks: [ostatiDaMargarita], libraryBooks: [danashauliDasSasjeli])
var giorgi = owner(ownerID: 2002, name: "გიორგი", borrowedBooks: [kafkaPliajze], libraryBooks: [danashauliDasSasjeli])

/* დიადი ბიბლიოთეკა*/

var diadiBiblioteka = library(libraryBooks: [danashauliDasSasjeli, ostatiDaMargarita, kafkaPliajze], owners: [soso, giorgi], booksNotYetInTheLibrary: [norvegiuliTye])

/* გიომ გაარბეინა დანაშაული და სასჯელი დიადი ბიბლიოთეკიდან */
giorgi.getABook(wigni1: danashauliDasSasjeli, wantToGet: true)

/* სოსომ დაუბრუნა კაფკუნია დიად ბიბლიოთეკას*/
soso.borrowedBooks = [kafkaPliajze]
soso.returnABook(whichBook: kafkaPliajze, wantToReturn: true)

/* სოსოს მიერ წაღებული წიგნებია*/
diadiBiblioteka.whatBooksOwnerHas(owneriko: soso)

/* გატანილი წიგნების სია*/

diadiBiblioteka.whichBooksBorrowed()

/* ბიბლიოში არსებული წიგნების სია */

diadiBiblioteka.whichBooksInLibrary()
