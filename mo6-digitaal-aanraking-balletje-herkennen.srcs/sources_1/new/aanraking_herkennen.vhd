----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2024 05:55:48 PM
-- Design Name: 
-- Module Name: aanraking_herkennen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity aanraking_herkennen is
    Port (
        grootte_balletje : in STD_LOGIC_VECTOR (7 downto 0);
        positie_balletje_x : in STD_LOGIC_VECTOR (8 downto 0);
        positie_balletje_y : in STD_LOGIC_VECTOR (8 downto 0);
        hoogte_peddels : in STD_LOGIC_VECTOR (7 downto 0);
        breedte_peddels : in STD_LOGIC_VECTOR (7 downto 0);
        locatie_peddel_1 : in STD_LOGIC_VECTOR (8 downto 0);
        locatie_peddel_2 : in STD_LOGIC_VECTOR (8 downto 0);
        aanraking_balletje_peddel : out STD_LOGIC;
        aanraking_peddel_deel : out STD_LOGIC_VECTOR (1 downto 0);
        aanraking_balletje_zijkant : out STD_LOGIC;
        aanraking_balletje_bovenonder : out STD_LOGIC
    );
end aanraking_herkennen;

architecture Behavioral of aanraking_herkennen is

    signal aanraking_rand_links : STD_LOGIC := '0';
    signal aanraking_rand_rechts : STD_LOGIC := '0';

    signal aanraking_peddel_links : STD_LOGIC := '0';
    signal aanraking_peddel_rechts : STD_LOGIC := '0';
    signal aanraking_peddel_deel_links : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal aanraking_peddel_deel_rechts : STD_LOGIC_VECTOR (1 downto 0) := "00";

    signal aanraking_bovenkant : STD_LOGIC := '0';
    signal aanraking_onderkant : STD_LOGIC := '0';

    signal grootte_balletje_uns : unsigned (7 downto 0);
    signal positie_balletje_x_uns : unsigned (8 downto 0);
    signal positie_balletje_y_uns : unsigned (8 downto 0);
    signal hoogte_peddels_uns : unsigned (7 downto 0);
    signal breedte_peddels_uns : unsigned (7 downto 0);
    signal locatie_peddel_1_uns : unsigned (8 downto 0);
    signal locatie_peddel_2_uns : unsigned (8 downto 0);

begin

    grootte_balletje_uns <= unsigned(grootte_balletje);
    positie_balletje_x_uns <= unsigned(positie_balletje_x);
    positie_balletje_y_uns <= unsigned(positie_balletje_y);
    hoogte_peddels_uns <= unsigned(hoogte_peddels);
    breedte_peddels_uns <= unsigned(breedte_peddels);
    locatie_peddel_1_uns <= unsigned(locatie_peddel_1);
    locatie_peddel_2_uns <= unsigned(locatie_peddel_2);

    aanraking_rand_links <= '1' when positie_balletje_x_uns = 0 else '0';
    aanraking_rand_rechts <= '1' when positie_balletje_x_uns + grootte_balletje_uns = 640 else '0';

    aanraking_peddel_links <= '1' when (positie_balletje_x_uns = breedte_peddels_uns) AND (positie_balletje_y_uns + grootte_balletje_uns > locatie_peddel_1_uns) AND (positie_balletje_y_uns < locatie_peddel_1_uns + hoogte_peddels_uns) else '0';
    aanraking_peddel_rechts <= '1' when (positie_balletje_x_uns + grootte_balletje_uns = 640 - breedte_peddels_uns) AND (positie_balletje_y_uns + grootte_balletje_uns > locatie_peddel_2_uns) AND (positie_balletje_y_uns < locatie_peddel_2_uns + hoogte_peddels_uns) else '0';

    aanraking_peddel_deel_links <=  "00" when   (positie_balletje_y_uns > locatie_peddel_1_uns + ((hoogte_peddels_uns * 3) / 8)) AND
                                                (positie_balletje_y_uns < locatie_peddel_1_uns + ((hoogte_peddels_uns * 5) / 8)) else
                                    "01" when   (((positie_balletje_y_uns > locatie_peddel_1_uns + (hoogte_peddels_uns / 4)) AND
                                                (positie_balletje_y_uns < locatie_peddel_1_uns + ((hoogte_peddels_uns * 3) / 8)))) OR
                                                (((positie_balletje_y_uns > locatie_peddel_1_uns + ((hoogte_peddels_uns * 5) / 8))) AND
                                                (positie_balletje_y_uns < locatie_peddel_1_uns + ((hoogte_peddels_uns * 3) / 4))) else
                                    "10" when   (((positie_balletje_y_uns > locatie_peddel_1_uns + (hoogte_peddels_uns / 8)) AND
                                                (positie_balletje_y_uns < locatie_peddel_1_uns + (hoogte_peddels_uns / 4)))) OR
                                                (((positie_balletje_y_uns > locatie_peddel_1_uns + ((hoogte_peddels_uns * 3) / 4))) AND
                                                (positie_balletje_y_uns < locatie_peddel_1_uns + ((hoogte_peddels_uns * 7) / 8))) else
                                    "11" when   (positie_balletje_y_uns < locatie_peddel_1_uns + (hoogte_peddels_uns / 8)) OR
                                                (positie_balletje_y_uns > locatie_peddel_1_uns + ((hoogte_peddels_uns * 7) / 8))
                                    else "00";
    aanraking_peddel_deel_rechts <=  "00" when  (positie_balletje_y_uns > locatie_peddel_2_uns + ((hoogte_peddels_uns * 3) / 8)) AND
                                                (positie_balletje_y_uns < locatie_peddel_2_uns + ((hoogte_peddels_uns * 5) / 8)) else
                                    "01" when   (((positie_balletje_y_uns > locatie_peddel_2_uns + (hoogte_peddels_uns / 4)) AND
                                                (positie_balletje_y_uns < locatie_peddel_2_uns + ((hoogte_peddels_uns * 3) / 8)))) OR
                                                (((positie_balletje_y_uns > locatie_peddel_2_uns + ((hoogte_peddels_uns * 5) / 8))) AND
                                                (positie_balletje_y_uns < locatie_peddel_2_uns + ((hoogte_peddels_uns * 3) / 4))) else
                                    "10" when   (((positie_balletje_y_uns > locatie_peddel_2_uns + (hoogte_peddels_uns / 8)) AND
                                                (positie_balletje_y_uns < locatie_peddel_2_uns + (hoogte_peddels_uns / 4)))) OR
                                                (((positie_balletje_y_uns > locatie_peddel_2_uns + ((hoogte_peddels_uns * 3) / 4))) AND
                                                (positie_balletje_y_uns < locatie_peddel_2_uns + ((hoogte_peddels_uns * 7) / 8))) else
                                    "11" when   (positie_balletje_y_uns < locatie_peddel_2_uns + (hoogte_peddels_uns / 8)) OR
                                                (positie_balletje_y_uns > locatie_peddel_2_uns + ((hoogte_peddels_uns * 7) / 8))
                                    else "00";

    aanraking_peddel_deel <= aanraking_peddel_deel_links when positie_balletje_x_uns < 320 else aanraking_peddel_deel_rechts;
        

    aanraking_bovenkant <= '1' when positie_balletje_y_uns = 0 else '0';
    aanraking_onderkant <= '1' when positie_balletje_y_uns + grootte_balletje_uns = 480 else '0';

    aanraking_balletje_peddel <= aanraking_peddel_links OR aanraking_peddel_rechts;
    aanraking_balletje_zijkant <= aanraking_rand_links OR aanraking_rand_rechts;
    aanraking_balletje_bovenonder <= aanraking_bovenkant OR aanraking_onderkant;

end Behavioral;
