#ifndef BACKEND_H
#define BACKEND_H

#include <QtCore/QObject>
#include <QJsonDocument>

typedef QString Dom;

class Backend : public QObject {
    Q_OBJECT

    Q_PROPERTY(Dom mapPanelData READ mapPanelData WRITE setMapPanelData NOTIFY mapPanelDataChanged)

public:
    Backend(QObject* parent = nullptr);
    ~Backend();

    Dom mapPanelData();
    void setMapPanelData(const Dom &map);

signals:
    void mapPanelDataChanged();

public slots:

    void onLayerAdd(const QString& dom);
    void onLayerChange(const QString& dom);
    void onLayerDelete(const QString& dom);
    //void onColorChange(const Dom& dom);
    void onSuitabilityMapAdd(const QString& dom);
    void onSuitabilityMapDelete(const QString& dom);
    void onSuitabilityMapChange(const QString& dom);
    void onSuitabilityMapActive(const QString& dom);
    void onSelectFeatureSets(const QString& dom);
    void onRefreshModel(const QString& dom);

private:
    Dom m_mapPanelData;
};

#endif // BACKEND_H
