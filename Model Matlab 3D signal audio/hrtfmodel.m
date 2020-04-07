function [ output ] = hrtfmodel(input, Azi, Ele, fs)
% La cartella HRIRData contiene misure effettuate tramite KEMAR
% per un insieme di angoli azimut ed elevazione
% per filtrare un segnale di ingresso selezionato

% Variabili di ingresso:
% Input - File audio definito dall'utente
% Azi - Angolo di Azimuth
% Ele - Angolo di elevazione
% fs - Frequenza di campionamento

% Uscita:
% Output - HRTF
% NB: Un file wav stereo viene creato nella fase di uscita
% e compare nella cartella corrente con HRTFoutput
% seguita dalla elevazione e l'azimut.

%% Orecchio sinistro - Richiamo dei dati dal lato sinistro e elaborazione della sorgente di ingresso con la risposta all'impulso risultante
filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e',num2str(Azi),'a.dat'); 
% Definire il nome del file da utilizzare basato sull' Azi e Ele

if Azi == 0
   filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e000a.dat'); % Se Azi è impostato su 0, tre 0 sono posti nel nome del file

elseif Azi > 0 && Azi < 10;
    filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e00',num2str(Azi),'a.dat'); % Se Azi è superiore a 0 e minore di 10, vengono aggiunti due 0
elseif Azi >= 10 && Azi < 99;
     filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e0',num2str(Azi),'a.dat'); % Se Azi è maggiore o uguale a 10 e fino a 99, si aggiunge un singolo 0
else
    filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e',num2str(Azi),'a.dat'); 
    % Per tutto il resto l'azimut può essere inserito direttamente nel nome del file
end

% Aprire il file definito e leggere i dati al suo interno 
	fpL = fopen(filenameL,'r','ieee-be'); % Apre il file come definito dalla funzione IF
	dataL = fread(fpL, 256, 'short'); % Legge i dati forniti dal file
	fclose(fpL); % Chiude nuovamente il file

	leftimp = dataL(1:2:256); % La risposta all'impulso che era stata letta dal file
    
left = filter(leftimp,1,input); % La fase in cui il segnale di ingresso viene filtrato dalla risposta all'impulso
left = left./max(abs(left)); % Il segnale principale è diviso da solo per portare tutti i dati in un range di sicurezza


Left_Output = left; % La risposta di uscita a sinistra.



%% Orecchio destro - Richiamo dei dati dal lato sinistro e elaborazione della sorgente di ingresso con la risposta all'impulso risultante
filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e',num2str(Azi),'a.dat');
% Definire il nome del file da utilizzare basato sull' Azi e Ele

if Azi == 0
    filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e000a.dat'); % Se Azi è impostato su 0, tre 0 sono posti nel nome del file
    
elseif Azi > 0 && Azi < 10;
    filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e00',num2str(Azi),'a.dat'); % Se Azi è superiore a 0 e minore di 10, vengono aggiunti due 0
elseif Azi >= 10 && Azi < 99;
     filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e0',num2str(Azi),'a.dat'); % Se Azi è maggiore o uguale a 10 e fino a 99, si aggiunge un singolo 0
else
    filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e',num2str(Azi),'a.dat');
    % Per tutto il resto l'azimut può essere inserito direttamente nel nome del file
end

% Aprire il file definito e leggere i dati al suo interno
	fpR = fopen(filenameR,'r','ieee-be'); % Apre il file come definito dalla funzione IF
	dataR = fread(fpR, 256, 'short'); % Legge i dati forniti dal file
	fclose(fpR); % Chiude nuovamente il file
    

    rightimp = dataR(1:2:256); % La risposta all'impulso che era stata letta dal file
	

right = filter(rightimp, 1, input);  % La fase in cui il segnale di ingresso viene filtrato dalla risposta all'impulso
right = right./max(abs(right));  % Il segnale principale è diviso da solo per portare tutti i dati in un range di sicurezza


Right_Output = right; % La risposta di uscita a sinistra.

%% Somma di uscita e il file wav di produzione
output = [Left_Output Right_Output]; % Somma stereo dei due file di uscita

wavwrite(output, fs, 32, strcat('HRTFOutput',num2str(Ele),'e',num2str(Azi),'a')); % Creazione di un file wav del segnale di uscita risultante

end

