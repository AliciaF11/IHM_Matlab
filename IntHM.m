function varargout = IntHM(varargin)
% INTHM MATLAB code for IntHM.fig
%      INTHM, by itself, creates texta new INTHM or raises the existing
%      singleton*.
%
%      H = INTHM returns the handle to texta new INTHM or the handle to
%      the existing singleton*.
%
%      INTHM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTHM.M with the given input arguments.
%
%      INTHM('Property','Value',...) creates texta new INTHM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IntHM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IntHM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IntHM

% Last Modified by GUIDE v2.5 27-Apr-2021 21:24:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IntHM_OpeningFcn, ...
                   'gui_OutputFcn',  @IntHM_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% init


% --- Executes just before IntHM is made visible.
function IntHM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IntHM (see VARARGIN)
global a 
global b
global N
global sigma
global class
global AFF 
global REG

global x
global y
global bruit
global yb
global yREG

global b0
global b1
global s0
global s1
global R2
% init;
load('init.mat') %on charge les valeurs initiales de a,b,N,sigma,class

[x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,0,1) %fonction simulation

[b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,0)%fonction extraction

data= {a,b1,s1;b,b0,s0;sigma,Sr,abs(sigma-Sr)/sigma} %tableau valeurs théoriques, expérimentales et erreurs
set(handles.table1,'Data',data)

%variable = valeur
set(handles.texta,'string',['Valeur: a=',num2str(a,2),'unités'])
set(handles.textb,'string',['Valeur: b=',num2str(b,2),'unités'])
set(handles.textN,'string',['Valeur: N=',int2str(N),'unités'])
set(handles.textsigma,'string',['Valeur: sigma=',num2str(sigma,2),'unités'])
set(handles.textclass,'string',['Valeur: class=',int2str(class),'unités'])

%graphique 1
axes(handles.axes1)
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y=', num2str(a),'X+',num2str(b)])

%graphique 2
axes(handles.axes2)
% on trace le graphique de la gaussienne 
plot(bruit)
% titre
title('Graphique du signal gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')

%graphique 3
axes(handles.axes3)
%on trace l'histogramme de la gaussienne
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe =',int2str(class)])
ylabel('Amplitude')

%graphique 4
axes(handles.axes4)
% subplot(2,2,4)

plot(x,yb,'.r')
%titre et légendes
title('Sortie du système linéaire bruité')
xlabel(['Nombre de points N = ', int2str(N)])
ylabel('Quantité de bruit')
% Choose default command line output for IntHM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IntHM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IntHM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function texta_Callback(hObject, eventdata, handles)
% hObject    handle to texta (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global a
a=get(hObject,'Value')
set(handles.texta,'string',['Valeur: a=',num2str(a,2),'unités'])

global a
global b
global N
global sigma
global class
global AFF
global REG

global x
global y
global bruit
global yb
global yREG

global b0
global b1
global s0
global s1
global R2

[x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,0,1)

[b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,0)
data= {a,b1,s1;b,b0,s0;sigma,Sr,abs(sigma-Sr)/sigma}
set(handles.table1,'Data',data)


axes(handles.axes1)
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y=', num2str(a),'X+',num2str(b)])

axes(handles.axes2)
% on trace le graphique de la gaussienne 
plot(bruit)
% titre
title('Graphique du signal gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')

axes(handles.axes3)
%on trace l'histogramme de la gaussienne
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe =',int2str(class)])
ylabel('Amplitude')

axes(handles.axes4)
% subplot(2,2,4)

plot(x,yb,'.r')
%titre et légendes
title('Sortie du système linéaire bruité')
xlabel(['Nombre de points N = ', int2str(N)])
ylabel('Quantité de bruit')

% hold on 
% plot(x,yREG,'-b')
% %title+légendes
% hold off



% --- Executes during object creation, after setting all properties.
function texta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texta (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global a 
% load init.mat %on charge le fichier avec les valeurs
texta=findobj(0,'tag','texta')
set(texta,'Value',a)
% Hint: slider controls usually have texta light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function textb_Callback(hObject, eventdata, handles)
% hObject    handle to textb (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% init(N,sigma,class,a,b)
global b
b=get(hObject,'Value')
set(handles.textb,'string',['Valeur: b=',num2str(b,2),'unités'])

global a
global b
global N
global sigma
global class
global AFF
global REG

global x
global y
global bruit
global yb
global yREG

global b0
global b1
global s0
global s1
global R2

[x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,0,1)

[b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,0)
data= {a,b1,s1;b,b0,s0;sigma,Sr,abs(sigma-Sr)/sigma}
set(handles.table1,'Data',data)

axes(handles.axes1)
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y=', num2str(a),'X+',num2str(b)])

axes(handles.axes2)
% on trace le graphique de la gaussienne 
plot(bruit)
% titre
title('Graphique du signal gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')

axes(handles.axes3)
%on trace l'histogramme de la gaussienne
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe =',int2str(class)])
ylabel('Amplitude')

axes(handles.axes4)
% subplot(2,2,4)

plot(x,yb,'.r')
%titre et légendes
title('Sortie du système linéaire bruité')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Quantité de bruit')

% hold on 
% plot(x,yREG,'-b')
% %title+légendes
% hold off


% --- Executes during object creation, after setting all properties.
function textb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textb (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global b 
% load init.mat %on charge le fichier avec les valeurs
textb=findobj(0,'tag','textb')
set(textb,'Value',b)
% Hint: slider controls usually have texta light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function textN_Callback(hObject, eventdata, handles)
% hObject    handle to textN (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% init(N,sigma,class,a,b)
global N
N=get(hObject,'Value')
N=300*N
N=floor(N)
set(handles.textN,'string',['Valeur: N=',int2str(N),'unités'])

global a
global b
global N
global sigma
global class
global AFF
global REG

global x
global y
global bruit
global yb
global yREG

global b0
global b1
global s0
global s1
global R2

[x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,0,1)

[b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,0)
data= {a,b1,s1;b,b0,s0;sigma,Sr,abs(sigma-Sr)/sigma}
set(handles.table1,'Data',data)

axes(handles.axes1)
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y=', num2str(a),'X+',num2str(b)])

axes(handles.axes2)
% on trace le graphique de la gaussienne 
plot(bruit)
% titre
title('Graphique du signal gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')

axes(handles.axes3)
%on trace l'histogramme de la gaussienne
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe =',int2str(class)])
ylabel('Amplitude')

axes(handles.axes4)
% subplot(2,2,4)

plot(x,yb,'.r')
%titre et légendes
title('Sortie du système linéaire bruité')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Quantité de bruit')

% hold on 
% plot(x,yREG,'-b')
% %title+légendes
% hold off


% --- Executes during object creation, after setting all properties.
function textN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textN (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global N
% load init.mat
textN=findobj(0,'tag','textN')
set(textN,'Value',N/300)
% Hint: slider controls usually have texta light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function textsigma_Callback(hObject, eventdata, handles)
% hObject    handle to textsigma (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% init(N,sigma,class,a,b)
global sigma
sigma=get(hObject,'Value')
sigma=30*sigma
set(handles.textsigma,'string',['Valeur: sigma=',num2str(sigma,2),'unités'])

global a
global b
global N
global sigma
global class
global AFF
global REG

global x
global y
global bruit
global yb
global yREG

global b0
global b1
global s0
global s1
global R2

[x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,0,1)

[b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,0)
data= {a,b1,s1;b,b0,s0;sigma,Sr,abs(sigma-Sr)/sigma}
set(handles.table1,'Data',data)

axes(handles.axes1)
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y=', num2str(a),'X+',num2str(b)])

axes(handles.axes2)
% on trace le graphique de la gaussienne 
plot(bruit)
% titre
title('Graphique du signal gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')

axes(handles.axes3)
%on trace l'histogramme de la gaussienne
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe =',int2str(class)])
ylabel('Amplitude')

axes(handles.axes4)
% subplot(2,2,4)

plot(x,yb,'.r')
%titre et légendes
title('Sortie du système linéaire bruité')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Quantité de bruit')

% hold on 
% plot(x,yREG,'-b')
% %title+légendes
% hold off

% --- Executes during object creation, after setting all properties.
function textsigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textsigma (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global sigma
% load init.mat
textsigma=findobj(0,'tag','textsigma')
set(textsigma,'Value',sigma/30)
% Hint: slider controls usually have texta light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function textclass_Callback(hObject, eventdata, handles)
% hObject    handle to textclass (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global class
class=get(hObject,'Value');
class=20*class
class=floor(class)
set(handles.textclass,'string',['Valeur: class=',int2str(class),'unités'])

global a
global b
global N
global sigma
global class
global AFF
global REG

global x
global y
global bruit
global yb
global yREG

global b0
global b1
global s0
global s1
global R2

[x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,0,1)

[b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,0)
data= {a,b1,s1;b,b0,s0;sigma,Sr,abs(sigma-Sr)/sigma}
set(handles.table1,'Data',data)

axes(handles.axes1)
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y=', num2str(a),'X+',num2str(b)])

axes(handles.axes2)
% on trace le graphique de la gaussienne 
plot(bruit)
% titre
title('Graphique du signal gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')

axes(handles.axes3)
%on trace l'histogramme de la gaussienne
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe =',int2str(class)])
ylabel('Amplitude')

axes(handles.axes4)
% subplot(2,2,4)

plot(x,yb,'.r')
%titre et légendes
title('Sortie du système linéaire bruité')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Quantité de bruit')

% hold on 
% plot(x,yREG,'-b')
% %title+légendes
% hold off

% --- Executes during object creation, after setting all properties.
function textclass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textclass (see GCBO)
% eventdata  reserved - to be defined in texta future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global class 
% load init.mat
textclass=findobj(0,'tag','textclass')
set(textclass,'Value',class/20)
% Hint: slider controls usually have texta light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes when entered data in editable cell(s) in table1.
function table1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE1)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function table1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to table1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
global AFF
AFF=1;


global a
global b
global N
global sigma
global class
global AFF
global REG

global x
global y
global bruit
global yb
global yREG

global b0
global b1
global s0
global s1
global R2

[x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,0,1)

[b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,0)
data= {a,b1,s1;b,b0,s0;sigma,Sr,abs(sigma-Sr)/sigma}
set(handles.table1,'Data',data)
