#include "Backend.h"
#include <QQmlApplicationEngine>

Backend::Backend(QObject * parent)
    : QObject(parent)
{

}

Backend::~Backend()
{

}

void Backend::onLayerAdd(const Dom& dom)
{
    qDebug("onLayerAdd\n");
}
void Backend::onLayerChange(const Dom& dom)
{

}
void Backend::onLayerDelete(const Dom& dom)
{

}
//void onColorChange(const Dom& dom);
void Backend::onSuitabilityMapAdd(const Dom& dom)
{

}
void Backend::onSuitabilityMapDelete(const Dom& dom)
{

}
void Backend::onSuitabilityMapChange(const Dom& dom)
{

}
void Backend::onSuitabilityMapActive(const Dom& dom)
{

}
void Backend::onSelectFeatureSets(const Dom& dom)
{

}
void Backend::onRefreshModel(const Dom& dom)
{

}
