/****************************************************************************
**
** Copyright (C) 2015-2018 Aleksandr Abramov
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
** http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
****************************************************************************/

#include "tme.h"
#include "tmemory.h"

//#include <algorithm>

namespace Memory
{

TME::TME():
  id_name_(-1)//, parent_(nullptr)
{

}

TME::TME(shared_me parent, int id_name, QVariant val):
  id_name_(id_name), val_(val), parent_(parent)
{
  //mem_ = static_cast<TMemory*>(mem);
//  if(parent_!=nullptr)
//    mem_ = parent_->mem_;
  //val_.setVal(val);
}

TME::TME(const TME &me)
{
  parent_ = me.parent_;
  *this = me;
}

TME::~TME()
{
  clear();
}

TME &TME::operator=(const TME &me)
{
  val_ = me.val_;
  id_name_ = me.id_name_;
  return *this;
}

QString TME::name() const
{
  TMemory *m = this->mem();
  if(m)
    return m->getWord(id_name_);
  return "";
}

void TME::setName(const QString &name)
{
  TMemory *m = this->mem();
  if(m) {
    id_name_ = m->getWordIdx(name);
  }
}

QVariant TME::val() const
{
  return val_.val();
}

void TME::setVal(const TMEValue &val)
{
  val_ = val;
}

void TME::setVal(const QVariant &val)
{
  val_.setVal(val);
}

TME::shared_me TME::parent() const
{
  return parent_.lock();
}

QString TME::getPath() const
{
  QString res ="";
  if(parent_.lock())
    res = parent_.lock()->getPath() + "\\";
  res += name();
  return res;
}

void TME::Add(const TME::shared_me &me)
{
    childs_.add(me);
}

bool TME::addFrom(shared_me mefrom, bool recurs, bool checkExist)
{
  bool res = false;
  if(!mefrom)
    return res;

  auto elements = mefrom->getElements();
  for(int i =0; i <elements.count(); ++i)
  {
    auto me1 = elements.get(i);
    shared_me me2 = nullptr;
    if(checkExist)
      me2 = Get(me1->name());
    if(!me2) {
      me2 = Add(me1->name());
      if(me2)
        me2->setVal(me1->val());
    }
    if(me2)
    {
      //me2->setVal(me1->val());

      if(recurs)
        res = me2->addFrom(me1, recurs, checkExist);
    }
  }

  res = true;

  return res;
}

TME::shared_me TME::Get(const QString &name)
{
  int idx =-1;
  TMemory *m = this->mem();

  if(m)
    idx = m->getWordIdx(name);

  if(idx >=0)
    return childs_.get_by_id_name(idx);

  return {nullptr};
}

bool TME::Del(const QString &name)
{
  TME *me = Get(name);
  if(me)
  {
    return( childs_.remove(me) );
  }
  return false;
}

bool TME::Del(shared_me me)
{
  if(me)
  {
    return( childs_.remove(me) );
  }
  return false;
}

void TME::clear()
{
  childs_.clear();
}

int TME::get_index() const
{
  int res = -1;
  if(parent_)
  {
    res = parent_->childs_.get_index(this);
  }
  return res;
}

bool TME::move_to(TME *parent, int pos)
{
  bool res = false;
  if(!parent || pos <0)
    return res;

  if(parent == parent_)
  {// переместить внутри текущего владельца
    res = parent_->childs_.move(get_index(), pos);
  }
  else
  {
    setParent(parent);//добавить в конец
    res = (parent ==parent_);

    if(res)
      res = move_to(parent, pos);//переместиться в позицию
  }
  return res;
}

void TME::load(QDataStream &ds)
{
  ds >> id_name_;
  val_.load(ds);
  childs_.load(ds, /*mem_,*/ this);
}

void TME::save(QDataStream &ds) const
{
  ds << id_name_;
  val_.save(ds);
  childs_.save(ds);
}

int TME::id_name() const
{
  return id_name_;
}

void TME::remove(const TME *me)
{
  childs_.remove(me);
}

TME::Elements &TME::getElements()
{
  return childs_;
}

TMemory *TME::mem() const
{
  if(!parent_) {
    auto topMe = reinterpret_cast<const TopME*>(this);
    return (topMe ? topMe->mem() : nullptr);
  }
  else
    return parent_->mem();
}

TMEData TME::data() const
{
  TMEData data;
  data.name_ = name();
  data.val_ = val();
  return data;
}

int TME::size()
{
  int res = 0;//sizeof(id_name_);
  //res += sizeof(val_);
  res += sizeof(std::weak_ptr<TME>);
  //res += sizeof(elements_svec);
  //res += sizeof(std::shared_ptr<Memory::TME>);
  return res;
}

void TME::setParent(shared_me parent)
{
  if(parent == parent_.lock())
    return;

//  if(parent_.lock())
//     parent_.lock()->remove(this);

  parent_ = parent;

//  if(parent_.lock())
//    parent_.lock()->childs_.add(this);
}

TME::Elements::Elements()
{
  //items_.reserve(10000);
}

TME::shared_me TME::Elements::add(int id, shared_me parent)
{
  //TME *me = nullptr;
  //if(id >=0)
  {
    //me = new TME(parent, id);
    items_.push_back({new TME(parent, id)});
  }
  return items_.back();

  //this->items_.insert(me->id_name(), me);
}

void TME::Elements::add(const shared_me &me)
{
  items_.push_back(me);
}

int TME::Elements::count() const
{
  return items_.size();
}

TME::shared_me TME::Elements::get(int i) const
{
  if(i <0 || i >=count())
    return {nullptr};
  return items_[i];
}

TME::shared_me TME::Elements::get_by_id_name(int id) const
{
  //TME *me = nullptr;
  for(const auto &mei: items_)
  {
    if(mei->id_name_ ==id)
    {
      //me = mei;
      return mei;
    }
  }
  return {};
}

bool TME::Elements::remove(const shared_me me)
{
  auto it = std::find(items_.begin(), items_.end(), me);
  if(it != items_.end())
  {
    //delete me;
    items_.erase(it);
    return true;
  }
  return false;
}

void TME::Elements::clear()
{
//  int cnt = items_.size();
//  for(int i =0; i <cnt; ++i)
//  {
//    delete items_[i];
//  }
  items_.clear();
}

int TME::Elements::get_index(const shared_me me) const
{
  //auto it = items_.find(me->id_name());
  auto it = std::find(items_.begin(), items_.end(), me);
  if(it !=items_.end())
    return std::distance(items_.begin(), it);
  return -1;
}

bool TME::Elements::move(int from, int to)
{
  if(from !=to && from >=0 && from <count() && to >=0 && to <count())
  {
    int delta = 1;
    if(from > to)
      delta = -1;
    auto x = items_.at(from);
    while(from != to)
    {
      items_[from] = items_[from + delta];
      from += delta;
    }
    items_[to] = x;

    //items_.insert(items_.begin() +to, x);
    //items_.erase(items_.begin() +from);
    return true;
  }
  return false;
}

void TME::Elements::load(QDataStream &ds, shared_me parent)
{
  int cnt = 0;
  ds >> cnt;

  for(int i =0; i <cnt; ++i)
  {
    auto me = add(0, /*mem,*/ parent);
    me->load(ds);
  }
}

void TME::Elements::save(QDataStream &ds) const
{
 int cnt = count();
 ds << cnt;

 for(auto me: items_)
 {
   me->save(ds);
 }
}

}
