#include "SoftCostPanel.h"
#include <QQmlApplicationEngine>

SoftCostPanel::SoftCostPanel(QQmlApplicationEngine* engine, QWidget * parent)
    : QDialog(parent)
{
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    engine->load(url);
}

SoftCostPanel::~SoftCostPanel()
{

}

void SoftCostPanel::updatePanel()
{

}

void SoftCostPanel::CallPanelFunction(const char* panel, const char* functionName, const Dom& args)
{

}


void SoftCostPanel::onLayerAdd(const Dom& dom)
{

}
void SoftCostPanel::onLayerChange(const Dom& dom)
{

}
void SoftCostPanel::onLayerDelete(const Dom& dom)
{

}
//void onColorChange(const Dom& dom);
void SoftCostPanel::onSuitabilityMapAdd(const Dom& dom)
{

}
void SoftCostPanel::onSuitabilityMapDelete(const Dom& dom)
{

}
void SoftCostPanel::onSuitabilityMapChange(const Dom& dom)
{

}
void SoftCostPanel::onSuitabilityMapActive(const Dom& dom)
{

}
void SoftCostPanel::onSelectFeatureSets(const Dom& dom)
{

}
void SoftCostPanel::onRefreshModel(const Dom& dom)
{

}
