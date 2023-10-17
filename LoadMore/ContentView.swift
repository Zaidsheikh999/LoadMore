//
//  ContentView.swift
//  LoadMore
//
//  Created by Zaid Sheikh on 08/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NewsFeedView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NewsFeedView: View {
    @ObservedObject var newsFeed = NewsFeed()
     
    var body: some View {
        NavigationView {
            List(newsFeed) { (article: NewsListItem) in
                NavigationLink(destination: NewsListItemView(article: article)) {
                    NewsListItemListView(article: article)
                        .onAppear {
                            self.newsFeed.loadMoreArticles(currentItem: article)
                    }
                }
            }
        .navigationBarTitle("Apple News")
        }
    }
}
 
struct NewsListItemView: View {
    var article: NewsListItem
     
    var body: some View {
        VStack {
            UrlWebView(urlToDisplay: URL(string: article.url)!)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle(article.title)
        }
    }
}
 
struct NewsListItemListView: View {
    var article: NewsListItem
     
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(article.title)")
                    .font(.headline)
                Text("\(article.author ?? "No Author")")
                    .font(.subheadline)
            }
        }
    }
}
