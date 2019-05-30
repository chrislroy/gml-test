#ifndef SOFTCOSTPANEL_H
#define SOFTCOSTPANEL_H

#include <QtCore/QObject>
#include <QtWidgets/QDialog>

typedef QString Dom;
class QQmlApplicationEngine;

class SoftCostPanel : public QDialog {
    Q_OBJECT
public:
    SoftCostPanel(QQmlApplicationEngine* engine, QWidget * parent = nullptr);
    ~SoftCostPanel();

    void updatePanel();

    void CallPanelFunction(const char* panel, const char* functionName, const Dom& args);

public slots:
    void onLayerAdd(const Dom& dom);
    void onLayerChange(const Dom& dom);
    void onLayerDelete(const Dom& dom);
    //void onColorChange(const Dom& dom);
    void onSuitabilityMapAdd(const Dom& dom);
    void onSuitabilityMapDelete(const Dom& dom);
    void onSuitabilityMapChange(const Dom& dom);
    void onSuitabilityMapActive(const Dom& dom);
    void onSelectFeatureSets(const Dom& dom);
    void onRefreshModel(const Dom& dom);

};

#endif // SOFTCOSTPANEL_H
