#include "Backend.h"
#include <QQmlApplicationEngine>
#include <QTimer>



Backend::Backend(QObject * parent)
    : QObject(parent)
{

}

Backend::~Backend()
{

}

Dom Backend::mapPanelData()
{
    return m_mapPanelData;
}

// methods that calls the QML presentation layer
void Backend::setMapPanelData(const Dom &mapPanelData)
{
    if (mapPanelData == m_mapPanelData)
        return;

    m_mapPanelData = mapPanelData;
    emit mapPanelDataChanged();
}


// method that is called by the QML presentation layer
void Backend::onLayerAdd(const Dom& dom)
{
    qDebug("onLayerAdd\n");
}

void Backend::onLayerChange(const Dom& dom)
{
    qDebug("onLayerChange\n");

}
void Backend::onLayerDelete(const Dom& dom)
{
    qDebug("onLayerDelete\n");

}
//void onColorChange(const Dom& dom);
void Backend::onSuitabilityMapAdd(const Dom& dom)
{
    qDebug("onSuitabilityMapAdd\n");

    //m_map = dom;

}
void Backend::onSuitabilityMapDelete(const Dom& dom)
{
    qDebug("onSuitabilityMapDelete\n");

}
void Backend::onSuitabilityMapChange(const Dom& dom)
{
    qDebug("onSuitabilityMapChange\n");
    //qDebug(qPrintable(dom));

    //QTimer::singleShot(200, [=](){ setMap(dom); } );
}

/**
* Adds a newly created layer to active SuitabilityMap
*
* When this should be called from SF:
*   - when active map changed
*
* @param dom
        {
            "File": "c:\\...\\unver\\SoftCosts\\SuitabilityMaps\\Map1.json"
        }
*   passing in null or empty means de-active active map
*
* @returns nothing
*/
void Backend::onSuitabilityMapActive(const Dom& dom)
{
    qDebug("onSuitabilityMapActive\n");
    qDebug(qPrintable(dom));



}

void Backend::onSelectFeatureSets(const Dom& dom)
{
    qDebug("onSelectFeatureSets\n");

}

void Backend::onRefreshModel(const Dom& dom)
{
    qDebug("onRefreshModel\n");

}
