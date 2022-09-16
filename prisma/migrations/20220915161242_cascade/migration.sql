-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Likes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "likes" INTEGER NOT NULL,
    "postsId" INTEGER,
    "commentsId" INTEGER,
    CONSTRAINT "Likes_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Likes_commentsId_fkey" FOREIGN KEY ("commentsId") REFERENCES "Comments" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Likes" ("commentsId", "id", "likes", "postsId") SELECT "commentsId", "id", "likes", "postsId" FROM "Likes";
DROP TABLE "Likes";
ALTER TABLE "new_Likes" RENAME TO "Likes";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
