import pandas as pd
import plotly.graph_objects as go
import plotly.express as px

Installierte_Kapazität = "IRENA_Stats_Extract_ 2024 H1.xlsx"

df_land = pd.read_excel(Installierte_Kapazität , sheet_name='Country') #Laden und anzeigen vom Blatt 'Country' der Excel Datei
df_land.head(5)

df_regional = pd.read_excel(Installierte_Kapazität , sheet_name='Regional') #Laden und anzeigen vom Blatt 'Regional' der Excel Datei
df_regional.head(5)

df_global = pd.read_excel(Installierte_Kapazität , sheet_name='Global') #Laden und anzeigen vom Blatt 'Global' der Excel Datei
df_global.head(5)

#Hier wird eine neue Spalte 
df_global["Percentage"] = df_global.groupby("Year")["Sum of Electricity Installed Capacity (MW)"].transform(
    lambda x: (x / x.sum()) * 100
)
df_global.head(5)

df_CO2 = pd.read_excel(Installierte_Kapazität , sheet_name='CO2') #Laden und anzeigen vom Blatt 'CO2' der Excel Datei
df_CO2.head(20)

df_land_CO2 = pd.merge(df_land, df_CO2, on='Technology', how='left')

df_land_CO2["CO2-Emissionen insgesammt"] = df_land_CO2["CO2-Emissionen pro MW"] * df_land_CO2["Electricity Installed Capacity (MW)"]

df_land_CO2.head(5)

df_global_CO2 = pd.merge(df_land, df_CO2, on='Technology', how='left')

df_global_CO2["CO2-Emissionen insgesammt"] = df_global_CO2["CO2-Emissionen pro MW"] * df_global_CO2["Electricity Installed Capacity (MW)"]

df_global_CO2 = df_global_CO2.groupby(["Year", 'Energieart DE'])['CO2-Emissionen insgesammt'].sum().reset_index().drop_duplicates()

df_global_CO2.head(5)

df_Regionen = pd.read_excel(Installierte_Kapazität , sheet_name='Regionen') #Laden und anzeigen vom Blatt 'Regionen' der Excel Datei

df_Regionen.head(20)


df_regionen_neu = pd.merge(df_regional, df_Regionen, on='Region', how='left')

df_regionen_neu = df_regionen_neu.groupby(["Year", "Regionen", 'Group Technology'])['Sum of Electricity Installed Capacity (MW)'].sum().reset_index().drop_duplicates()

df_regionen_neu.head(5)


df_regionen_neu_RE = pd.merge(df_regional, df_Regionen, on='Region', how='left')

df_regionen_neu_RE = df_regionen_neu_RE.groupby(["Year", "Regionen", "RE or Non-RE"])['Sum of Electricity Installed Capacity (MW)'].sum().reset_index().drop_duplicates()

df_regionen_neu_RE.head(5)


df_global_neu_RE = pd.merge(df_regional, df_Regionen, on='Region', how='left')

df_global_neu_RE = df_global_neu_RE.groupby(["Year", "RE or Non-RE"])['Sum of Electricity Installed Capacity (MW)'].sum().reset_index().drop_duplicates()

df_global_neu_RE.head(5)


import pandas as pd
import plotly.express as px

df_global_bar = df_global

# Calculate percentages for each year and technology group
df_global_bar["Percentage"] = df_global_bar.groupby("Year")["Sum of Electricity Installed Capacity (MW)"].transform(
    lambda x: (x / x.sum()) * 100
)

# Create the bar chart
fig_global_kapazität = px.bar(
    df_global_bar,
    x="Year",
    y="Sum of Electricity Installed Capacity (MW)",
    color="Group Technology",
    custom_data=["Percentage"],
    title="Weltweit installierte Kapatität nach Energieart in MW",
)

# Customize hover template to display percentages
fig_global_kapazität.update_traces(hovertemplate="Jahr: %{x} <br>Kapazität: %{y:.2f} MW<br>Prozent: %{customdata[0]:.2f}%")

# Update layout title and labels
fig_global_kapazität.update_layout(
    title="Weltweit installierte Kapatität nach Energieart in MW",
    xaxis_title="Jahr",
    yaxis_title="Installierte Kapazität in MW",
    legend_title="Energie Art"
)

import pandas as pd
import plotly.express as px

df_global_bar = df_global

# Calculate percentages for each year and technology group
df_global_bar["Percentage"] = df_global_bar.groupby("Year")["Sum of Electricity Installed Capacity (MW)"].transform(
    lambda x: (x / x.sum()) * 100
)

# Create the bar chart
fig_global_kapazität_relativ = px.bar(
    df_global_bar,
    x="Year",
    y="Percentage",
    color="Group Technology",
    custom_data=["Percentage"],
    title="Weltweit installierte Kapatität nach Energieart in Prozent",
)

# Customize hover template to display percentages
fig_global_kapazität_relativ.update_traces(hovertemplate="Jahr: %{x} <br>Kapazität: %{y:.2f} MW<br>Prozent: %{customdata[0]:.2f}%")

# Update layout title and labels
fig_global_kapazität_relativ.update_layout(
    title="Weltweit installierte Kapatität nach Energieart in Prozent",
    xaxis_title="Jahr",
    yaxis_title="Installierte Kapazität in Prozent",
    legend_title="Energie Art"
)


df_global_bar = df_global_neu_RE

# Calculate percentages for each year and technology group
df_global_bar["Percentage"] = df_global_bar.groupby("Year")["Sum of Electricity Installed Capacity (MW)"].transform(
    lambda x: (x / x.sum()) * 100
)

# Create the bar chart
fig_global_fosil_erneuerbar_absolut= px.bar(
    df_global_bar,
    x="Year",
    y="Sum of Electricity Installed Capacity (MW)",
    color="RE or Non-RE",
    custom_data=["Percentage"],
    title="Weltweite Kapazität nach fosiler und erneuerbarer Energie",
)

# Customize hover template to display percentages
fig_global_fosil_erneuerbar_absolut.update_traces(hovertemplate="Jahr: %{x} <br>Kapazität: %{y:.2f} MW<br>Prozent: %{customdata[0]:.2f}%")

# Update layout title and labels
fig_global_fosil_erneuerbar_absolut.update_layout(
    title="Weltweite Kapazität nach fosiler und erneuerbarer Energie",
    xaxis_title="Jahr",
    yaxis_title="Installierte Kapazität in MW",
    legend_title="Energie Art"
)


df_global_bar = df_global_neu_RE

# Calculate percentages for each year and technology group
df_global_bar["Percentage"] = df_global_bar.groupby("Year")["Sum of Electricity Installed Capacity (MW)"].transform(
    lambda x: (x / x.sum()) * 100
)

# Create the bar chart
fig_global_fosil_erneuerbar_relativ = px.bar(
    df_global_bar,
    x="Year",
    y="Percentage",
    color="RE or Non-RE",
    custom_data=["Percentage"],
    title="Weltweite Kapazität nach fosiler und erneuerbarer Energie in Prozent",
)

# Customize hover template to display percentages
fig_global_fosil_erneuerbar_relativ.update_traces(hovertemplate="Jahr: %{x} <br>Kapazität: %{y:.2f} MW<br>Prozent: %{customdata[0]:.2f}%")

# Update layout title and labels
fig_global_fosil_erneuerbar_relativ.update_layout(
    title="Weltweit installierte Kapatität nach erneuerbaren und fosilen Energien in Prozent",
    xaxis_title="Jahr",
    yaxis_title="Installierte Kapazität in Prozent",
    legend_title="Energie Art"
)
import plotly.express as px

df = df_regionen_neu

colors = {
    'Bioenergy': '#00CC96',
    'Fossil fuels': '#9D755D',
    'Geothermal energy': '#FECB52',
    'Hydropower (excl. Pumped Storage)': '#19D3F3',
    'Nuclear': '#00CC66',
    'Pumped storage': '#636EFA',
    'Solar energy': '#FF9900',
    'Wind energy': '#B3E880',
    'Marine energy': 'teal',
    'Other non-renewable energy': '#7F7F7F'
}

# Create the bar chart with facet_col and category order
fig_region_kapazität_absolut = px.bar(
    df,
    x="Year",
    y="Sum of Electricity Installed Capacity (MW)",
    color="Group Technology",
    color_discrete_map=colors,
    facet_col="Regionen",
    category_orders={"Regionen": ["Asien", "Europa", "Nord Amerika", "Süd Amerika", "Afrika", "Ozeanien"]},
)

import plotly.express as px

df = df_regionen_neu

df["Prozent"] = df.groupby(["Year", "Regionen"])["Sum of Electricity Installed Capacity (MW)"].transform(
    lambda x: (x / x.sum()) * 100
)

colors = {
    'Bioenergy': '#00CC96',
    'Fossil fuels': '#9D755D',
    'Geothermal energy': '#FECB52',
    'Hydropower (excl. Pumped Storage)': '#19D3F3',
    'Nuclear': '#00CC66',
    'Pumped storage': '#636EFA',
    'Solar energy': '#FF9900',
    'Wind energy': '#B3E880',
    'Marine energy': 'teal',
    'Other non-renewable energy': '#7F7F7F'
}

# Create the bar chart with facet_col and category order
fig_region_kapazität_relativ = px.bar(
    df,
    x="Year",
    y="Prozent",
    color="Group Technology",
    color_discrete_map=colors,
    facet_col="Regionen",
    category_orders={"Regionen": ["Asien", "Europa", "Nord Amerika", "Süd Amerika", "Afrika", "Ozeanien"]},
)

import plotly.express as px
df = df_regionen_neu_RE

fig = px.bar(df, x="Year", y="Sum of Electricity Installed Capacity (MW)", color="RE or Non-RE",
             facet_col="Regionen",
            category_orders={"Regionen": ["Asien", "Europa", "Nord Amerika", "Süd Amerika", "Afrika", "Ozeanien"]},
)

# Calculate total CO2 emissions by country and year (assuming 'Year' exists in df_merged)
df_emissions_by_country = df_land_CO2.groupby(['Country', 'Year', "RE or Non-RE"])['Electricity Installed Capacity (MW)'].sum().reset_index()

df_emissions_by_country["Percentage"] = df_emissions_by_country.groupby(["Year", "Country"])["Electricity Installed Capacity (MW)"].transform(
    lambda x: (x / x.sum()) * 100
)

colors = ['brown', 'orange', 'yellow', 'green']

karte_erneuerbare_energie = px.choropleth(df_emissions_by_country,  # Use the DataFrame with year information
                      locations="Country",
                      locationmode="country names",
                      color="Percentage",  # Use column name from DataFrame
                      animation_frame="Year",
                      color_continuous_scale=colors,
                      title="Anteil erneuerbarer Energien von der Gesamtkapazität")

#karte_erneuerbare_energie.update_traces(hovertemplate=["Country", "Year", "Percentage"])


karte_erneuerbare_energie.update_layout(geo=dict(showframe=False, showcoastlines=False),
                      coloraxis_colorbar=dict(title="Grün Erneuerbar"),
                      margin=dict(l=0, r=0, t=40, b=0))


# Calculate total CO2 emissions by country and year (assuming 'Year' exists in df_merged)
df_renewable_by_country = df_land_CO2.groupby(['Country', 'Year', "CO2 arm"])['Electricity Installed Capacity (MW)'].sum().reset_index()

df_renewable_by_country["Percentage"] = df_renewable_by_country.groupby(["Year", "Country"])["Electricity Installed Capacity (MW)"].transform(
    lambda x: 100 - (x / x.sum()) * 100
)

colors = ['brown', 'orange', 'yellow', 'green']

karte_CO2_arm = px.choropleth(df_renewable_by_country,  # Use the DataFrame with year information
                      locations="Country",
                      locationmode="country names",
                      color="Percentage",  # Use column name from DataFrame
                      animation_frame="Year",
                      color_continuous_scale=colors,
                      title="Anteil CO2 armer Energie von der Gesamtkapazität (Erneuerbar + Kernkraft)",
)

karte_CO2_arm.update_layout(geo=dict(showframe=False, showcoastlines=False),
                      coloraxis_colorbar=dict(title="Grün veniger CO2"),
                      margin=dict(l=0, r=0, t=40, b=0),
)


import pandas as pd
import plotly.express as px

df_global_bar = df_global_CO2

# Create the bar chart
CO2_nach_energieart = px.bar(
    df_global_bar,
    x="Year",
    y="CO2-Emissionen insgesammt",
    color="Energieart DE",
    title="Weltweiter CO2-Ausstoß",
)

# Customize hover template to display percentages
CO2_nach_energieart.update_traces(hovertemplate="Jahr: %{x} <br>CO2-Ausstoß: %{y} ")

# Update layout title and labels
CO2_nach_energieart.update_layout(
    title="Weltweiter CO2-Ausstoß",
    xaxis_title="Jahr",
    yaxis_title="CO2-Ausstoß",
    legend_title="Energie Art"
)



df_Solar_photovoltaic = df_land[df_land["Technology"] == "Solar photovoltaic"]
line_chart = px.line(df_Solar_photovoltaic, x='Year', y= 'Electricity Installed Capacity (MW)' , color='Country')

# Titel und Beschriftungen festlegen
line_chart.update_layout(title='Installierte Kapatität in MW nach Jahren von 2000 bis 2023', xaxis_title='Jahr', yaxis_title='Instllierte Kapazität in MW', )


    # Import packages
import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_bootstrap_components as dbc  
import pandas as pd
import plotly.express as px
from dash.dependencies import Input, Output

# Incorporate data
df = df_global
df2 = df_CO2


df_technologie = df_land
verfügbare_technologie = df_land["Sub-Technology"].unique()
available_countries = df_land["Country"].unique()


# Initialize the app
app = dash.Dash(__name__, external_stylesheets=[dbc.themes.CYBORG])
server = app.server

# App layout
app.layout = dbc.Container([

    dcc.Markdown('''# **Energiequelle der Zukunft? **   ''' ),
                          
    dcc.Markdown('''## **Ein datenbasierter Blick auf die weltweite Energielandschaft in Bezug auf den CO2-Ausstoß** '''),

    dbc.Row([
        dbc.Col([

            dcc.Markdown('''
                 Es gibt aktuell kein wichtigeres Thema wie den Klimawandel. Wir spüren bereits heute schon die Auswirkungen des Klimawandels in Form von Extremwettern, steigendem Meeresspiegel und schmelzenden Gletschern wie auch Permafrostböden.
                 Ein Beispiel sind die gewaltigen Überschwemungen in Pakistan im Sommer 2023 oder auch in Deutschland die Flut im Ahrtal 2021.
                 Der Kimawandel ist schon heute eine Gefahr für viele Menschen und wenn wir nichts dagegen unternehmen wird es eine existenzielle Bedrohung für uns alle und viele weitere Tierarten.
                 Das im Pariser Klimaabkommen festgehaltene 1,5 Grad Ziel erfordert eine drastische reduktion des CO2 ausstoßses und anderen Treibhausgasen um noch schlimmerere Folgen zu verhindern.
                 Die Stromerzeugung spielt dabei eine enorme Rolle, da Weltweit aktuell 37,2 Millirden Tonnen CO2 ausgestoßen werden und davon ca. 37% auf den Energiesektor ausfallen.

                 Um eine umfassenden Überblick über die Energiegewinnung der einzelnen Länder zu bekommen habe ich den IRENA-Datensatz gewählt.
                 Mit Hilfe von diesem Datensatz habe ich im Folgenden die Energielandschaft der Welt von 2000 bis 2023 analysiert.
                
                 Das Balkendiagramm zeigt die Entwicklung der Stromerzeugung von dem Jahr 2000 bis 2023. Wie man sieht ist die gesamt Energiekapazität stetig angestiegen und hat sich mitlerweile vervierfacht.
                 Dabei sieht man auch, dass die erneuerbaren Energien seit 2010 immer mehr an Bedeutung gewinnen und in zwischen fast 50% der gesamt Kapazität ausmachen,
                 was aber auch bedeutet das sich die Menge an fosiler Energie auch verdoppelt hat in den letzten 20 Jahren.
                 Die erneurbaren Energien setzen sich großteis aus Wasser, Wind und Solar zusammensetzen wobei andere erneuerbare Energien nur einen kleineren Teil ausmachen. 
                 Man muss jedoch beachten, dass es sich hier um die **Kapazität handelt und nicht die Tatsächlich produzierte Energie** in den Jahren.
                 
                 '''),
        ]),
    ]),


    dbc.Row([
        dbc.Col([
            dcc.Dropdown(
                id='chart-dropdown1',
                options=[
                    {'label': 'Globale Kapazität nach Energieart (absolut)', 'value': 'chart1'},
                    {'label': 'Globale Kapazität nach Energieart (relativ)', 'value': 'chart2'},
                ],
                value='chart1',
                className="mb-3"
            ),
            dcc.Graph(id='chart-output1', className="mb-3")
        ]),
    ]),


    dbc.Col([
        dcc.Dropdown(
            id='chart-dropdown2',
            options=[
                {'label': 'Globale Kapazität nach Energieart (absolut)', 'value': 'chart3'},
                {'label': 'Globale Kapazität nach Energieart (relativ)', 'value': 'chart4'},
            ],
            value='chart3',
            className="mb-3"
        ),
        dcc.Graph(id='chart-output2', className="mb-3")
    ]),

        
    dbc.Col([    
        dcc.Markdown('''
                 
                 Im nächsten Schritt habe ich nun die Zumannemsetzung der Energie in den einzelnen Kontinenten angeschaut.
                 Wie man sieht ist der Anteil erneuerbarer Energien in Europa zuerst angestiegen dicht, gefolgt von Nord Amerika und Asien.
                 Der steigende Anteil erneuerbaren Energien entwickeln sich somit zuerst in den Industrieländern gefolgt von den Schwellenländern.
                 Dies lässt sich einfach erklären, denn die Technologie wurde in eben diesen Ländern entwickelt und somit auch dort zuerst eingeführt.

                 Man sieht jedoch auch gerade an Asien, wo China und Indien den größten Teil der Energieproduktion ausmachen, dass zwar relativ früh der Ausbau erneuerbarer Energien forangeschritten ist,
                 der absolute Strom bedarf ebenfalls gewaltig angestiegen ist und sich vervierfacht hat.
                 Somit ist zwar der Anteil der erneuerbaren Energie gestiegen, der absolute Anteil der fosilen Energie hat sich jedoch seit dem Jahr 2000 auch verdreifacht.

                 Was aber auch deutlich zu sehen ist, ist das es gerade in Afrika und Süd Amerika schlechter aussieht mit dem Bau von erneuerbaren Energien.
                 Einige befürchten deshalb, dass es dort genau so ablaufen wird wie in China und Indien, dass zwar auch erneuerbare Energie gebaut wird jedoch mit sehr hoher Wascheinlichkeit
                 zuerst auch auf viel auf fosile Energie gesetzt wird, denn diese ist in vielen Fällen oft einfacher und billiger zu bauen, da das Wissen dafür schon vorhanden ist, welches für erneuerbare Energie fehlt.
                 Damit diese Länder somit nicht die gleiche Entwicklung durchgehen ist dort die Unterstützung der Industrieländern gefragt, um die globale Energiewende zu bewältigen.
                 Dise Ünterstützen kann in Form von Vermittlung von fehlendem Wissen oder auch duch direkte Unterstützung bein Aufbau.

                 '''),
    ]),

    dbc.Col([             
        dcc.Dropdown(
            id='chart-dropdown3',
            options=[
                {'label': 'Globale Kapazität nach Erneuerbar und Fosil (absolut)', 'value': 'chart5'},
                {'label': 'Globale Kapazität nach Erneuerbar und Fosil (relativ)', 'value': 'chart6'},
            ],
            value='chart5',  # Default chart to display
            className="mb-3",
        ),
        dcc.Graph(id='chart-output3', className="mb-3"),
    ]),

    dbc.Col([
        dcc.Markdown('''
             
                 Um noch genauer die Zusammensetzung des Strommixes der einzelnen Ländern anzuschauen hilft diese Karte, welche den Anteil der erneuerbaren Energie in Prozent von der Gesamtkapazität angibt. 
                 Je grüner ein Land ist, desto mehr der Energie wird aus erneuerbaren Quellen gewonnen.

                 Was mich verwundert hat ist die Tatsache, dass in Afrika im Jahr 2000 einige Länder als sehr erneuerbar angezeigt werden, welche mit der Zeit aber immer dunkler werden.
                 Das liegt einerseits an der Datengrundlage, da es für die ersten Jahre aus manchen Ländern nicht für alle Energiearten Daten gibt, 
                 andererseits kann es auch daran liegen, dass die elektrifizierung in vielen der Afrikanischen Ländern nicht so vorangeschritten ist wie in anderen Teilen der Welt.
                 Die Vorhin angesprochene Befürchtung, dass in Afrika das Gleiche passiert wie in China und Indien, wird hier durch die Karte auch nochmal deutlicher, 
                 mit dem schnellen Anstieg des Anteils der fosiler Energie in wenigen Jahren, der meist auch bis heute noch hoch ist.
                 
             '''),
                 
        dcc.Graph(id='map-eneuerbar', figure=karte_erneuerbare_energie, className="mb-3"),

    ]),

    dbc.Col([
        dcc.Markdown('''

                 In Bezug auf den Klimawandel ist natürlich der verursachte CO2-Ausstoß pro MW und nach Energieart von großer Bedeutung.
                 Um dies zu berechnen habe ich die im Schnitt ausgestoßene Menge an CO2 pro MW nach Energieart genommen. 
                 Da es sich um den Schnitt von der gesamten Welt handelt gibt auch Länder in denen der Wert für CO2 pro MW geringer und höher ist, es gibt jedoch nur für wenige Länder spezifische Daten.

                 Zuerst aber einmal über 90% vom CO2-Ausstoß stammt von fosilen Energien obwohl diese nur noch 50% von der gesamt Energie weltweit ausmachen.
                 Hinzu kommt auch, dass sich der gesamt CO2-Ausstoß in den letzten 20 Jahren voerdoppelt hat, obwohl seit mindestens 15 Jahren immerhin schon etwas für erneuerbare Energie gemcht wird.
                 Es wurde jedoch viel zu wenig dafür gemacht, nicht nur in Deutschland sondern auf der gesamten Welt.
                 Man muss jedoch auch festhalten das Kohle und Erdgas den größten Anteil am CO2-Ausstoß haben, was auch damit zusammenhängt, dass Kohle den schlechtesten Wert mit 820g CO2-Äquvivalent pro kWh hat, 
                 wohingegen Erdgas 'nur' 490g CO2-Äquvivalent pro kWh ausstößt.
                 Bei den sonstigen fosilen Energien wird von einem großen Anteil an Kohle ausgegeangen weshalb hier ein Wert von 700g CO2-Äquvivalent pro kWh angenommen wird.
              
             '''),

        dcc.Graph(id='graph-CO2', figure=CO2_nach_energieart, className="mb-3"),

    ]),

    dbc.Col([
        dcc.Markdown('''

                 Um nun nocheinmal auf die Karte zu schauen, hier wird diesmal der Anteil der CO2-armen Energieerzeugung angezeigt. Dazu zählen die erneuerbaren Energien und die Nuklearenergie.
                 Man erkennt auf der Karte nun, das Länder wie Frankreich welche viel auf Atomstrom setzen, was den CO2-Ausstoß angeht besser dastehen als Länder wie Deutschland welche viel auf Kohle setzen.
                 Es heißt also nich nur weil der Anteil ernuerbarer Energie größer ist, dass auch der CO2-Ausstoß geringer ist, sondern es kommt auch darauf an welche Art von Energie verwendet wird egal ob ernuerbar oder fosil.
                 
              
             '''),

        dcc.Graph(id='map-CO2', figure=karte_CO2_arm, className="mb-3"),

    ]),

    dbc.Col([
        dcc.Markdown('''

                 ### Fazit

                 Es wird Welteit immer mehr für erneuerbare Energie gemacht und der Anteil der erneuerbaren Energien nimmt von Jahr zu Jahr stetig zu, was erstmal ein gutes Zeichen ist. 
                 Der absolute Anteil der fosilen Energie hat sich jedoch auch verdoppelt, was auf dem Weg zu einer CO2-Neutralen Stromerzeugung natürlich hinderlich ist.
                 Es gibt somit noch viel zu machen um tatsächlich im Energiesektor CO2-Neutral zu werden.

                 Man darf jetzt natürlich nicht vergessen, dass der Energiesektor nur ein Teil des gesamt CO2-Ausstoßes ist und in den Bereichen wie Transport, Industrie und Gebäuden auch veiles gemacht werden muss.
                 Die Energiewende ist eine globale Aufgabe zu der jedes Land seinen Beitrag leisten muss, jedoch auch jeder einzelne seinen Beitrag dazu geben kann.
                 Mit vereinten Kräften werden wir die Energiewende bewältigen und so einen größen Teil zur bewältigung des Klimawandels beitragen um eine lebenswerte Welt zu schaffen.         
              
             '''),

        dcc.Markdown('''

                 ### Quellen

                 * Irena-Datensatz: https://www.irena.org/Data/View-data-by-topic/Capacity-and-Generation/Country-Rankings

                 * CO2 Emissionen: https://www.ipcc.ch/site/assets/uploads/2018/02/ipcc_wg3_ar5_annex-iii.pdf#page=7

                 * CO2 Emissionen: https://github.com/electricitymaps/electricitymaps-contrib/wiki/Default-emission-factors 

                               

             '''),

    ]),

    dbc.Col([
        dcc.Dropdown(
            id="dropdown-länder",
            options=[{"label": c, "value": c} for c in available_countries],
            className="mb-3",
            value=["Deutschland"], 
            multi=True,
        ),

        dcc.Dropdown(
            id="dropdown-technologie",
            options = [{"label": c, "value": c} for c in verfügbare_technologie],
            className="mb-3",
        ),

        dcc.Graph(id="Kapazität_nach_Technologie", className="mb-3"),
    ])
])

@app.callback(
    Output("Kapazität_nach_Technologie", "figure"),
    Input("dropdown-länder", "value"),
    Input("dropdown-technologie", "value"),
)
def update_chart(selected_countries, selected_technologies):
    # Filtern der Daten nach ausgewählten Ländern und Technologien
    filtered_df = df_land[
        (df_land["Country"].isin(selected_countries)) & (df_land["Sub-Technology"] == selected_technologies)
    ]

    # Erstellen des Line-Charts mit Plotly Express
    line_chart = px.line(
        filtered_df,
        x="Year",
        y="Electricity Installed Capacity (MW)",
        color="Country",
        facet_col="Technology",
        title="Installierte Kapazität in MW nach Jahren (2000-2023)",
    )

    return line_chart

@app.callback(
    Output('chart-output1', 'figure'),  # Update chart 1
    Input('chart-dropdown1', 'value')  # Input from dropdown 1
)
def update_chart1(selected_chart1):  # Receive value from dropdown 1
    # Update logic based on selected_chart1
    if selected_chart1 == 'chart1':
        return fig_global_kapazität  # Return figure for chart1
    elif selected_chart1 == 'chart2':
        return fig_global_kapazität_relativ  # Return figure for chart2
    else:
        raise ValueError('Invalid chart option')

@app.callback(
    Output('chart-output2', 'figure'),  # Update chart 2
    Input('chart-dropdown2', 'value')  # Input from dropdown 2
)
def update_chart2(selected_chart2):  # Receive value from dropdown 2
    # Update logic based on selected_chart2
    if selected_chart2 == 'chart3':
        return fig_global_fosil_erneuerbar_absolut  # Return figure for chart3
    elif selected_chart2 == 'chart4':
        return fig_global_fosil_erneuerbar_relativ  # Return figure for chart4
    else:
        raise ValueError('Invalid chart option')    

@app.callback(
    Output('chart-output3', 'figure'),  # Update chart 2
    Input('chart-dropdown3', 'value')  # Input from dropdown 2
)
def update_chart2(selected_chart2):  # Receive value from dropdown 2
    # Update logic based on selected_chart2
    if selected_chart2 == 'chart5':
        return fig_region_kapazität_absolut  # Return figure for chart3
    elif selected_chart2 == 'chart6':
        return fig_region_kapazität_relativ  # Return figure for chart4
    else:
        raise ValueError('Invalid chart option')

if __name__ == "__main__":
    app.run_server(jupyter_mode="external", debug=True, port=8050)  # Start the server on port 8050