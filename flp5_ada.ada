-- Exercice 1 ----------------------------------------------------------------------

-- a) retourne un boolean correspond au resultat du test (false si t ne contient pas que des 0, true sinon)
FOR I IN Table'RANGE LOOP
   IF(T(I) /= 0) THEN RETURN False; END IF;
END LOOP;
RETURN True;

--  b) Retourne true si les éléments de T sont en ordre croissant, false sinon
FOR I IN 1..(Table'length-1) LOOP
   IF(T(I) > T(I+1)) THEN RETURN False; END IF;
END LOOP;
RETURN True;

-- c) Retourne true si la première case du tableau contient un entier positif, false sinon
IF(T'First > 0) THEN RETURN True;
ELSE RETURN False;
END IF;

-- d) Retourne true si la première et la dernière case d'un tableau sont égales, false sinon
IF(T'First = T'Last) THEN RETURN True;
ELSE RETURN False;
end if;

------------------------------------------------------------------------------------


-- Exercice 2 ----------------------------------------------------------------------

WITH Ada.Text_IO, Ada.Integer_Text_IO;
use ada.Text_IO, ada.Integer_Text_IO;

PROCEDURE Exo2 IS
   TYPE Jour IS (Lundi, Mardi, Mercredi, Jeudi, Vendredi, Samedi, Dimanche);
   TYPE Mois IS (Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,Decembre);
   SUBTYPE Int31 IS Integer RANGE 1..31;
   type t_int is array(integer range 1..10) of integer;
   
   TYPE Date IS RECORD
      J : Jour;
      No_J : Int31;
      M : Mois;
      a : integer;   
   END RECORD;
   
   -- Détermine si une mesure de température est pertinente ou non
   FUNCTION Valide(Temp : float) RETURN Boolean is
   BEGIN
      IF(Temp < 42.0 AND Temp > 35.0) THEN RETURN True;
      ELSE RETURN False;
      end if;
   end valide;

   -- Permute le ième et le jème élément d'un tableau
   PROCEDURE Permute1(Tab : IN OUT T_Int; I,J : IN Integer) IS 
      temp : integer := tab(i);
   BEGIN
      Tab(I) := Tab(J);
      tab(j) := temp;
   End permute1;

   -- Permute le 1er et le ième élément d'un tableau
   PROCEDURE Permute2(Tab : IN OUT T_Int; I : IN Integer) IS 
      temp : integer := tab(1);
   BEGIN
      Tab(1) := Tab(i);
      tab(i) := temp;
   END Permute2;
   
   -- Dis si une date est avant une autre
   FUNCTION Avant(D1,D2 : Date) RETURN Date IS
   BEGIN
      IF(D1.A < D2.A) THEN RETURN D1;
      ELSIF(D1.A = D2.A) THEN
         IF(Mois'Pos(D1.M) < Mois'Pos(D2.M)) THEN RETURN D1;
         ELSIF(Mois'Pos(D1.M) = Mois'Pos(D2.M)) THEN
            IF(D1.No_J < D2.No_J) THEN RETURN D1;
            ELSE RETURN D2;
            END IF;
         ELSE RETURN D2;
         END IF;
      ELSE RETURN D2;
      END IF;
   END Avant;
   
   -- Affiche une date donnée dans l'ordre chronologique
   PROCEDURE Print_Date(D1,D2 : IN Date) IS
      d3 : date;
   BEGIN
      D3 := Avant(D1,D2);
      
      IF(D3.J = D1.J AND D3.M=D1.M AND D3.A=D1.A) THEN
         Put("Date 1 : "); Put(jour'image(D1.J)); Put(D1.No_J); Put(mois'image(D1.M)); Put(D1.A);
         Put("Date 2 : "); Put(jour'image(D2.J)); Put(D2.No_J); Put(mois'image(D2.M)); Put(D2.A);
      ELSE
         Put("Date 1 : "); Put(jour'image(D2.J)); Put(D2.No_J); Put(mois'image(D2.M)); Put(D2.A);
         Put("Date 2 : "); Put(jour'image(D1.J)); Put(D1.No_J); Put(mois'image(D1.M)); Put(D1.A);
      END IF;
   END Print_Date;
   
   -- Recherche un entier x dans un tableau, l'échange avec la dernière case et retourne un boolean correspondant au succès
   PROCEDURE Cherche_Et_Remplace(Tab : IN OUT T_Int; X : IN Integer; Donne : OUT Boolean) IS
   BEGIN
      Donne := False;
      
      FOR I IN T_Int'RANGE LOOP
         if(tab(i) = x) then permute2(tab,t_int'length); end if;
      end loop;
   end cherche_et_remplace;
   
   -- Détermine le nombre de jours dans un mois donné pour une année donnée
   FUNCTION Nbre_Jours(M : Mois; A : Integer) RETURN Int31 IS
   BEGIN
      IF(M=Avril OR M=Juin OR M=Septembre OR M=Novembre) THEN RETURN 30;
      ELSIF(M=Fevrier) THEN
         IF(A mod 100 /= 0 AND A mod 400 = 0) THEN RETURN 29;
         ELSE RETURN 29;
         END IF;
      else return 31;
      end if;
   end nbre_jours;
   
   -- Détermine la date de la veille
   FUNCTION Veille(D : Date) RETURN Date IS
      new_d : date := d;
   BEGIN
      IF(D.J = Jour'First) THEN New_D.J := Jour'Last;
      ELSE New_D.J := Jour'pred(D.J);
      END IF;
      
      IF(D.No_J = 1) THEN
         IF(Mois'Pos(D.M) = 0) THEN 
            New_D.M := Mois'last;
            new_d.a := d.a-1;
         ELSE
            New_D.M := Mois'pred(D.M);
         END IF;
         new_d.no_j := nbre_jours(new_d.m, new_d.a);
      ELSE New_D.No_J := D.No_J-1;
      END IF;
      return new_d;
   END Veille;
   
   d : date;
BEGIN
   D.J := Lundi;
   D.No_J := 1;
   D.A := 2014;
   D.M := Janvier;
   
   D := Veille(D);
   put(jour'image(d.j)); put(d.no_j); put(mois'image(d.m)); put(d.a); new_line;
End exo2;

------------------------------------------------------------------------------------

-- Exercice 3 ----------------------------------------------------------------------

WITH Ada.Text_IO, Ada.Integer_Text_IO;
USE Ada.Text_IO, Ada.Integer_Text_IO;

PROCEDURE Flp_Exo3 IS
   TYPE Table IS ARRAY(Integer RANGE 1..50) OF Integer;
   t1, t2, diff : table;
BEGIN
   T1 := (OTHERS=>0);
   T2 := (OTHERS=>0);
   
   -- Affichage de T1
   put("T1 : ");
   FOR I IN T1'RANGE LOOP
      Put(T1(I),Width=>0); Put("-");
   END LOOP;
   New_Line;
   
   -- Affichage de T2
   put("T2 : ");
   FOR I IN reverse T2'RANGE LOOP
      Put(T1(I),Width=>0); Put("-");
   END LOOP;
   New_Line;
   
   -- Affichage de la différence entre les 2 tableaux
   FOR I IN Diff'RANGE LOOP
      Diff(I) := T1(I)-T2(I);
      put(diff(i),width=>0); put("-");
   END LOOP; 
   New_Line; 
   
   -- Affichage des liens entre les 2 tableaux
   FOR I IN T1'RANGE LOOP
      Put(I,Width=>0); 
      IF(T1(I) = 2*T2(I)) THEN Put_Line(" : DOUBLE");
      elsIF(T1(I) = t2(i)) THEN Put_Line(" : EGAL");
      ELSE Put_Line(": PAS DE LIEN");
      end if;   
   end loop;
End flp_exo3;

------------------------------------------------------------------------------------

-- Exercice 4 ----------------------------------------------------------------------

WITH Ada.Text_IO, Ada.Integer_Text_IO;
USE Ada.Text_IO, Ada.Integer_Text_IO;

PROCEDURE Flp5_Exo4 IS
   TYPE Binaire_10 IS ARRAY(Integer RANGE 1..10) OF Integer;
   
   Nbr_Binaire : Binaire_10;
   nbr : integer := 0;
BEGIN
   -- saisie du binaire et calcul du nombre en base 10
   FOR I IN Nbr_Binaire'RANGE LOOP
      Put("Bit "); Put(I,Width=>0); Put(" : "); Get(Nbr_Binaire(I)); Skip_Line; 
      if(nbr_binaire(i) = 1) then Nbr := Nbr+2**(i-1); end if;
   END LOOP;
   
   put("Base 10 : "); put(nbr,width=>0);
End flp5_exo4;

------------------------------------------------------------------------------------

