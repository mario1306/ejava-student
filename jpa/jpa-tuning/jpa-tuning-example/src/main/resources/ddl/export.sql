--------------------------------------------------------
--  DDL for PERSON
--------------------------------------------------------
CREATE UNIQUE INDEX SYS_C0012112" ON JPATUNE_PERSON" ("ID") ;
CREATE UNIQUE INDEX SYS_C0012113" ON JPATUNE_PERSON" ("LAST_NAME", "FIRST_NAME", "MOD_NAME") ;
ALTER TABLE JPATUNE_PERSON" ADD PRIMARY KEY ("ID"); 
ALTER TABLE JPATUNE_PERSON" ADD UNIQUE ("LAST_NAME", "FIRST_NAME", "MOD_NAME");
  
--------------------------------------------------------
--  DDL for ACTOR
--------------------------------------------------------
CREATE UNIQUE INDEX ACTOR_PK ON JPATUNE_ACTOR" ("PERSON_ID") ;
CREATE UNIQUE INDEX SYS_C0012131" ON JPATUNE_ACTOR" ("LAST_NAME", "FIRST_NAME", "MOD_NAME") ;
ALTER TABLE JPATUNE_ACTOR" ADD CONSTRAINT "ACTOR_PK PRIMARY KEY ("PERSON_ID"); 
ALTER TABLE JPATUNE_ACTOR" ADD UNIQUE ("LAST_NAME", "FIRST_NAME", "MOD_NAME");
ALTER TABLE JPATUNE_ACTOR" ADD CONSTRAINT "ACTOR_PERSON_FK" FOREIGN KEY ("PERSON_ID") REFERENCES JPATUNE_PERSON" ("ID") ENABLE;

--------------------------------------------------------
--  DDL for DIRECTOR
--------------------------------------------------------
CREATE UNIQUE INDEX DIRECTOR_PK ON JPATUNE_DIRECTOR" ("PERSON_ID") ;
CREATE UNIQUE INDEX SYS_C0012114" ON JPATUNE_DIRECTOR" ("LAST_NAME", "FIRST_NAME", "MOD_NAME") ;
ALTER TABLE JPATUNE_DIRECTOR" ADD CONSTRAINT "DIRECTOR_PK PRIMARY KEY ("PERSON_ID"); 
ALTER TABLE JPATUNE_DIRECTOR" ADD UNIQUE ("LAST_NAME", "FIRST_NAME", "MOD_NAME");
ALTER TABLE JPATUNE_DIRECTOR" ADD CONSTRAINT "DIRECTOR_PERSON_FK" FOREIGN KEY ("PERSON_ID") REFERENCES JPATUNE_PERSON" ("ID") ENABLE;

--------------------------------------------------------
--  DDL for MOVIEGENRE
--------------------------------------------------------
CREATE UNIQUE INDEX MOVIEGENRE_UNIQUE ON JPATUNE_MOVIEGENRE" ("MOVIE_ID", "GENRE") ;

--------------------------------------------------------
--  DDL for MOVIEROLE
--------------------------------------------------------
CREATE INDEX MOVIEROLE_ACTOR_FKX ON JPATUNE_MOVIEROLE" ("ACTOR_ID") ;
CREATE INDEX MOVIEROLE_MOVIE_FKX ON JPATUNE_MOVIEROLE" ("MOVIE_ID") ;
CREATE UNIQUE INDEX SYS_C0012136" ON JPATUNE_MOVIEROLE" ("MOVIE_NAME", "MOVIE_ROLE", "LAST_NAME", "FIRST_NAME", "MOD_NAME") ;

--------------------------------------------------------
--  DDL for MOVIE
--------------------------------------------------------
ALTER TABLE JPATUNE_MOVIE" MODIFY ("ID" NOT NULL ENABLE); 
ALTER TABLE JPATUNE_MOVIE" MODIFY ("TITLE" NOT NULL ENABLE);
ALTER TABLE JPATUNE_MOVIE" MODIFY ("NAME" NOT NULL ENABLE); 
ALTER TABLE JPATUNE_MOVIE" ADD PRIMARY KEY ("ID");
ALTER TABLE JPATUNE_MOVIE" ADD UNIQUE ("NAME");
ALTER TABLE JPATUNE_MOVIE" ADD CONSTRAINT "MOVIE_DIRECTOR_FK" FOREIGN KEY ("DIRECTOR_ID") REFERENCES JPATUNE_DIRECTOR" ("PERSON_ID") ENABLE;

--------------------------------------------------------
--  DDL for MOVIEROLE
--------------------------------------------------------
CREATE UNIQUE INDEX SYS_C0012120" ON JPATUNE_MOVIE" ("ID") ;
CREATE UNIQUE INDEX SYS_C0012121" ON JPATUNE_MOVIE" ("NAME") ;
ALTER TABLE JPATUNE_MOVIEROLE" MODIFY ("MOVIE_ROLE" NOT NULL ENABLE); 
ALTER TABLE JPATUNE_MOVIEROLE" MODIFY ("MOVIE_NAME" NOT NULL ENABLE);
ALTER TABLE JPATUNE_MOVIEROLE" ADD UNIQUE ("MOVIE_NAME", "MOVIE_ROLE", "LAST_NAME", "FIRST_NAME", "MOD_NAME");
ALTER TABLE JPATUNE_MOVIEROLE" MODIFY ("MOVIE_ID" NOT NULL ENABLE);
ALTER TABLE JPATUNE_MOVIEROLE" ADD CONSTRAINT "MOVIEROLE_ACTOR_FK" FOREIGN KEY ("ACTOR_ID") REFERENCES JPATUNE_ACTOR" ("PERSON_ID") ENABLE;
ALTER TABLE JPATUNE_MOVIEROLE" ADD CONSTRAINT "MOVIEROLE_MOVIE_FK" FOREIGN KEY ("MOVIE_ID") REFERENCES JPATUNE_MOVIE" ("ID") ENABLE;

--------------------------------------------------------
--  DDL for MOVIEROLEGENRE
--------------------------------------------------------
CREATE UNIQUE INDEX SYS_C0012127" ON JPATUNE_MOVIEGENRE" ("MOVIE_NAME", "GENRE") ;
ALTER TABLE JPATUNE_MOVIEGENRE" ADD CONSTRAINT "MOVIEGENRE_UNIQUE" UNIQUE ("MOVIE_ID", "GENRE"); 
ALTER TABLE JPATUNE_MOVIEGENRE" MODIFY ("GENRE" NOT NULL ENABLE); 
ALTER TABLE JPATUNE_MOVIEGENRE" MODIFY ("MOVIE_NAME" NOT NULL ENABLE); 
ALTER TABLE JPATUNE_MOVIEGENRE" ADD UNIQUE ("MOVIE_NAME", "GENRE"); 
ALTER TABLE JPATUNE_MOVIEGENRE" MODIFY ("MOVIE_ID" NOT NULL ENABLE);
ALTER TABLE JPATUNE_MOVIEGENRE" ADD CONSTRAINT "MOVIEGENRE_MOVIE_FK" FOREIGN KEY ("MOVIE_ID") REFERENCES JPATUNE_MOVIE" ("ID") ENABLE;
