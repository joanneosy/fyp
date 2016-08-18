/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.ConnectionManager;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriter.MaxFieldLength;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.SimpleFSDirectory;
import org.apache.lucene.util.Version;

public class Search {

    public static final File INDEX_DIRECTORY = new File("IndexDirectory");

    public int createIndex(String tableName) {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int noOfColumns = -1;
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement("SELECT count(*) AS NoOfColumns FROM information_schema.`COLUMNS` C WHERE table_schema = 'fyp' and table_name = '" + tableName + "'");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                noOfColumns = rs.getInt("NoOfColumns");
            }

            pstmt = conn.prepareStatement("SELECT * FROM " + tableName);
            rs = pstmt.executeQuery();
            //Lucene Section
            Directory directory = new SimpleFSDirectory(INDEX_DIRECTORY);
            Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_30);
            IndexWriter iWriter = new IndexWriter(directory, analyzer, true, MaxFieldLength.UNLIMITED);

            //Looping through resultset and adding to index file
            while (rs.next()) {
                Document doc = new Document();
                for (int i = 1; i <= noOfColumns; i++) {
                    doc.add(new Field(i + "", rs.getString(i), Field.Store.YES, Field.Index.ANALYZED));

                }

                //Adding doc to iWriter
                iWriter.addDocument(doc);
            }

            //Closing iWriter
            iWriter.optimize();
            iWriter.commit();
            iWriter.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
            return noOfColumns;
        }

    }

    public TopDocs search(String keyword, int noOfColumns) {

        try {
            //Searching
            IndexReader reader = IndexReader.open(FSDirectory.open(INDEX_DIRECTORY), true);
            IndexSearcher searcher = new IndexSearcher(reader);
            Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_30);
            //MultiFieldQueryParser is used to search multiple fields
            String[] filesToSearch = new String[noOfColumns];

            for (int i = 1; i <= noOfColumns; i++) {
                filesToSearch[i - 1] = i + "";
            }

            MultiFieldQueryParser mqp = new MultiFieldQueryParser(Version.LUCENE_30, filesToSearch, analyzer);
            Query query = mqp.parse(keyword);//search the given keyword
            TopDocs hits = searcher.search(query, 100); // run the query
            return hits;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /*public static void main(String[] args) throws SQLException, IOException {

        Search obj = new Search();

        //creating index
        int no = obj.createIndex("shops");

        //searching keyword
        TopDocs hits = obj.search("def", no);
        IndexReader reader = IndexReader.open(FSDirectory.open(INDEX_DIRECTORY), true);
        IndexSearcher searcher = new IndexSearcher(reader);
        for (int i = 0; i < hits.totalHits; i++) {
            Document doc = searcher.doc(hits.scoreDocs[i].doc);//get the next  document
            System.out.println(doc.get("1") + " " + doc.get("2") + " " + doc.get("3"));
        }
        //using wild card serach
        //obj.search("def*", no);

        //using logical operator
        //obj.search("def OR abc", no);
        //obj.search("AbC AND bukit", no);
    }*/
}
