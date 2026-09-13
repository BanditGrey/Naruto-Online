package Processors.Game.Lobby.Jade
{
   import Components.ComboBox.TComboBox;
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Queries.TQueryString;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TMasterStone;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TCollectionInventory;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_JADE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_JADE;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TJadeShengXing extends TProcessorLobbyWindow
   {
      
      public static const Ten:int = 10;
      
      public static const TenB:int = 12;
      
      protected var FFatherUI:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FCurrentShowEquipmentBag:TInventories;
      
      protected var FUIPageHeroList:TUIPage;
      
      protected var FRoleIndex:int;
      
      protected var FPageIndexHeroList:int;
      
      protected var FJadeLevelComboBox:TComboBox;
      
      protected var FJadeLevelComboBoxSelectIndex:int;
      
      protected var FJadeTypeComboBox:TComboBox;
      
      protected var FJadeTypeComboBoxSelectIndex:int;
      
      protected var FMC_LeftSlot:TUISlot;
      
      protected var CaiLiaoYuVector:Vector.<TUISlot>;
      
      protected var FList_SingleEquipment:Vector.<TSingelJageList>;
      
      protected var FList_SingleEquipmentFeiQi:Vector.<TSingelJageList>;
      
      protected var CurInventory:TInventory;
      
      protected var CurSingleEquip:TSingelJageList;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FCharacter:TCharacter;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var TempInventories:TInventories;
      
      protected var IDTemplates:Vector.<uint>;
      
      protected var FMC_TunShi:MovieClip;
      
      protected var FMC_QiangLiTunShi:MovieClip;
      
      protected var FMC_Shengxing:MovieClip;
      
      protected var FBtn_Left:MovieClip;
      
      protected var FBtn_Right:MovieClip;
      
      protected var FCurPageIndex:int;
      
      protected var FNameConfig:Vector.<Object>;
      
      protected var FNameConfig2:Vector.<Object>;
      
      protected var FCurBagCanXiaoShiJade:TInventories;
      
      protected var FIsInilization:Boolean;
      
      protected var FCurHeroId:uint;
      
      protected var FSelectBox:Sprite;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnInventoryOverCopy:Function;
      
      protected var FOnInventoryOutCopy:Function;
      
      protected var FFlyText:Function;
      
      public var EffectGenerateTextByErrorCode:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var MasterStoneBins:TBins;
      
      protected var FShaiXuanLevel:int;
      
      protected var FTunShiBackFucntion:Function;
      
      protected var FTF_JadeName:TextField;
      
      protected var FTF_JadeArrt:TextField;
      
      protected var FTF_JadeNextNme:TextField;
      
      protected var FTF_JadeNextArrt:TextField;
      
      protected var TTF_ShengJiDec:TextField;
      
      protected var TMC_Xing9:MovieClip;
      
      protected var TMC_ProgressBarExp:MovieClip;
      
      protected var TTF_Experience:TextField;
      
      protected var FCaiLiaoYuClick:TInventory;
      
      protected var FCurCaiLiaoYuIndex:int;
      
      public function TJadeShengXing(param1:TUIComponent)
      {
         super(param1);
         this.FList_SingleEquipment = new Vector.<TSingelJageList>();
         this.CaiLiaoYuVector = new Vector.<TUISlot>(TenB);
         this.FList_SingleEquipmentFeiQi = new Vector.<TSingelJageList>();
         this.FCharacter = SLogicsCore.Character;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.IDTemplates = new Vector.<uint>();
         this.TempInventories = new TInventories();
         this.FCurBagCanXiaoShiJade = new TInventories();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Function = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Vector.<DisplayObject> = null;
         var _loc7_:Array = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:TUISlot = null;
         var _loc10_:TConfigValue = null;
         this.addChild(param1);
         this.FFatherUI = param1;
         this.FSelectBox = TUtilityReflection.CreateDisplayObjectInstance("Select_box") as Sprite;
         this.FSelectBox.mouseEnabled = false;
         this.FSelectBox.visible = false;
         param1.addChild(this.FSelectBox);
         this.FUITab = new TUITab(this);
         _loc2_ = 0;
         while(_loc2_ < CONST_JADE.MAX_HeroCount)
         {
            this.FUITab.SetTabByIndex(param1["mc_hero_" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.Init();
         this.FUITab.OnSwitch = this.RoleTabOnSwitch;
         addChild(this.FUITab);
         _loc5_ = param1["mc_list"];
         this.FScrollBar = new TScrollBar(_loc5_,295,false,0);
         _loc2_ = 0;
         while(_loc2_ < TenB)
         {
            _loc9_ = new TUISlot(this);
            _loc5_ = param1["mc_stone_" + _loc2_];
            _loc9_.Resource = _loc5_;
            TJadeCommon.InitSlot(_loc9_,CONST_MODULES.MODULE_Jade);
            _loc9_.OnClick = this.ShengJiSlotOnClick;
            this.CaiLiaoYuVector[_loc2_] = _loc9_;
            _loc9_.Init();
            _loc9_.OnOverlay = this.SlotsOnMoveCopy;
            _loc9_.OnOut = this.SlotsOnOutCopy;
            _loc2_++;
         }
         this.FUIPageHeroList = new TUIPage(this);
         this.FUIPageHeroList.ButtonPrevious.Substrate = param1["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPageHeroList.ButtonNext.Substrate = param1["MC_HeroPage"]["MC_PageRight"];
         this.FUIPageHeroList.LabelPage = param1["MC_HeroPage"]["TF_Page"];
         this.FUIPageHeroList.PageSize = CONST_JADE.MAX_HeroCount;
         this.FUIPageHeroList.OnChangePage = this.HeroListPageOnChange;
         this.FUIPageHeroList.Init();
         this.FMC_LeftSlot = new TUISlot(this);
         _loc5_ = param1["MC_CurJadeSlot"];
         this.FMC_LeftSlot.Resource = _loc5_;
         TJadeCommon.InitSlot(this.FMC_LeftSlot,CONST_MODULES.MODULE_Jade);
         this.FMC_LeftSlot.OnClick = this.CurShengJiSlotOnClick;
         this.FMC_LeftSlot.Init();
         this.FMC_LeftSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_LeftSlot.OnOut = this.SlotsOnOut;
         this.FCurrentShowEquipmentBag = new TInventories();
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60100050) as TConfigValue;
         this.FNameConfig = _loc10_.Value as Vector.<Object>;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60100052) as TConfigValue;
         this.FNameConfig2 = _loc10_.Value as Vector.<Object>;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60100051) as TConfigValue;
         this.FShaiXuanLevel = _loc10_.Value as int;
         _loc6_ = new Vector.<DisplayObject>();
         _loc3_ = int(this.FNameConfig.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = this.MakeComboItem(this.FNameConfig[_loc2_][1]);
            _loc6_.push(_loc8_);
            _loc2_++;
         }
         this.FJadeLevelComboBox = new TComboBox(this,param1["MC_ChangeArea"],_loc6_,CONST_JADE.MAX_ComboboxHeight,this.OnLevelSelect);
         _loc6_.length = 0;
         _loc3_ = int(this.FNameConfig2.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = this.MakeComboItem(this.FNameConfig2[_loc2_][1]);
            _loc6_.push(_loc8_);
            _loc2_++;
         }
         this.FJadeTypeComboBox = new TComboBox(this,param1["MC_ArrtArea"],_loc6_,CONST_JADE.MAX_ComboboxHeight,this.OnTypeSelect);
         this.FMC_TunShi = param1["MC_YuUP"]["MC_TunShi"];
         this.FMC_QiangLiTunShi = param1["MC_YuUP"]["MC_QiangLiTunShi"];
         this.FMC_Shengxing = param1["MC_YuUnlock"]["MC_ShengXing"];
         this.FBtn_Left = param1["Btn_Left"];
         this.FBtn_Right = param1["Btn_Right"];
         this.FTF_JadeName = param1["TF_JadeName"];
         this.FTF_JadeArrt = param1["TF_JadeArrt"];
         this.FTF_JadeNextNme = param1["TF_JadeNextNme"];
         this.FTF_JadeNextArrt = param1["TF_JadeNextArrt"];
         this.TTF_ShengJiDec = param1["TF_ShengJiDec"];
         this.TMC_Xing9 = param1["MC_Xing9"];
         this.TMC_ProgressBarExp = param1["MC_ExpBar"]["MC_ProgressBarExp"];
         this.TTF_Experience = param1["MC_ExpBar"]["TF_Experience"];
         this.FIsInilization = true;
         this.MasterStoneBins = SLogicsCore.LostShenQiLogicData.MasterStoneBins;
      }
      
      public function Perform_UILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         this.FBtn_Left.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FBtn_Right.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_TunShi.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_QiangLiTunShi.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_Shengxing.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBtn_Left:
               if(!this.FBtn_Left.buttonMode)
               {
                  return;
               }
               --this.FCurPageIndex;
               this.SetValueForJade();
               this.UpdateJadePageIdex();
               break;
            case this.FBtn_Right:
               if(!this.FBtn_Right.buttonMode)
               {
                  return;
               }
               ++this.FCurPageIndex;
               this.SetValueForJade();
               this.UpdateJadePageIdex();
               break;
            case this.FMC_TunShi:
               if(!this.FMC_TunShi.buttonMode)
               {
                  return;
               }
               if(this.FTunShiBackFucntion != null)
               {
                  this.FTunShiBackFucntion(this.CurInventory,this.FCaiLiaoYuClick,this.FCurHeroId,0);
                  if(this.FCaiLiaoYuClick.Quantity == 1)
                  {
                     this.FCaiLiaoYuClick = null;
                  }
               }
               break;
            case this.FMC_QiangLiTunShi:
               if(!this.FMC_QiangLiTunShi.buttonMode)
               {
                  return;
               }
               if(this.FTunShiBackFucntion != null)
               {
                  this.FTunShiBackFucntion(this.CurInventory,this.FCaiLiaoYuClick,this.FCurHeroId,1);
               }
               break;
            case this.FMC_Shengxing:
               if(this.FTunShiBackFucntion != null)
               {
                  this.FTunShiBackFucntion(this.CurInventory,this.FCaiLiaoYuClick,this.FCurHeroId,2);
               }
               this.CurInventory = null;
               this.UpdateView();
         }
      }
      
      public function set TunShiBackFucntion(param1:Function) : void
      {
         this.FTunShiBackFucntion = param1;
      }
      
      protected function UpdateJadePageIdex() : void
      {
         TGameUtil.setButtonMode(this.FBtn_Left,true);
         TGameUtil.setButtonMode(this.FBtn_Right,true);
         if(this.FCurPageIndex <= 0)
         {
            this.FCurPageIndex = 0;
            TGameUtil.setButtonMode(this.FBtn_Left,false);
         }
         var _loc1_:int = this.FCurBagCanXiaoShiJade.Count / TenB;
         if(this.FCurPageIndex >= _loc1_)
         {
            this.FCurPageIndex = _loc1_;
            TGameUtil.setButtonMode(this.FBtn_Right,false);
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TMasterStone = null;
         var _loc6_:TArticle = null;
         var _loc7_:TMasterStone = null;
         var _loc8_:* = undefined;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TAppliance = null;
         var _loc12_:int = 0;
         _loc2_ = this.FList_SingleEquipment.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.FList_SingleEquipment[_loc3_].BClick = false;
            _loc3_++;
         }
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = true;
         }
         if(this.CurInventory)
         {
            this.FTF_JadeName.text = this.CurInventory.Name;
            this.FTF_JadeArrt.text = this.CurInventory.Description;
            _loc4_ = this.CurInventory.IDTemplate;
            _loc7_ = SLogicsCore.LostShenQiLogicData.MasterStoneBins.GetDatebaseByIdentifier(_loc4_) as TMasterStone;
            if(_loc7_.Level == 15)
            {
               this.CurInventory = null;
               this.UpdateView();
               return;
            }
            _loc4_++;
            _loc5_ = SLogicsCore.LostShenQiLogicData.MasterStoneBins.GetDatebaseByIdentifier(_loc4_) as TMasterStone;
            if(_loc5_)
            {
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc4_) as TArticle;
               this.FTF_JadeNextNme.text = _loc6_.Name;
               this.FTF_JadeNextArrt.text = _loc6_.FunctionDesc;
               this.TTF_Experience.text = TUtilityString.Format(STRING_JADE.STRING_Exp,this.CurInventory.CurJadeExp,_loc7_.NeedExp);
               this.TTF_ShengJiDec.text = TUtilityString.Format(STRING_JADE.STRING_ShenJiCost,_loc7_.NeedExp - this.CurInventory.CurJadeExp);
               if(this.CurInventory.CurUnlock == 0)
               {
                  this.FFatherUI["MC_YuUP"].visible = _loc7_.Level <= 10;
               }
               else
               {
                  this.FFatherUI["MC_YuUP"].visible = this.CurInventory.CurUnlock >= this.CurInventory.IDTemplate;
               }
               this.FFatherUI["MC_YuUnlock"].visible = !this.FFatherUI["MC_YuUP"].visible;
               if(this.FFatherUI["MC_YuUnlock"].visible)
               {
                  _loc8_ = TMasterStone(SLogicsCore.LostShenQiLogicData.MasterStoneBins.GetDatebaseByIdentifier(this.CurInventory.IDTemplate)).Costjheart;
                  _loc8_ = JSON.parse(_loc8_);
                  if(_loc8_.length > 0)
                  {
                     _loc9_ = uint(_loc8_[0]);
                     _loc10_ = uint(_loc8_[1]);
                     _loc11_ = SLogicsCore.Character.Appliances.GetInventoryByTempletID(_loc9_) as TAppliance;
                     if(_loc11_ == null)
                     {
                        _loc12_ = 0;
                     }
                     else
                     {
                        _loc12_ = int(_loc11_.Quantity);
                     }
                     this.FFatherUI["MC_YuUnlock"]["TF_Cailiao"].text = _loc12_ + "/" + _loc10_;
                     this.FFatherUI["MC_YuUnlock"]["TF_Cailiao"].textColor = _loc12_ >= _loc10_ ? 65331 : 16724787;
                     TGameUtil.setButtonMode(this.FMC_Shengxing,_loc12_ >= _loc10_);
                  }
               }
               this.TMC_ProgressBarExp.scaleX = this.CurInventory.CurJadeExp / _loc7_.NeedExp;
            }
            if(this.FCaiLiaoYuClick)
            {
               TGameUtil.setButtonMode(this.FMC_TunShi,true);
               TGameUtil.setButtonMode(this.FMC_QiangLiTunShi,true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FMC_TunShi,false);
               TGameUtil.setButtonMode(this.FMC_QiangLiTunShi,false);
            }
         }
         else
         {
            this.RestView();
         }
      }
      
      public function RestView() : void
      {
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
            this.CurSingleEquip = null;
         }
         this.TTF_Experience.text = "";
         this.TMC_ProgressBarExp.scaleX = 0;
         this.TMC_Xing9.visible = false;
         this.TTF_ShengJiDec.text = "";
         this.FTF_JadeNextArrt.text = "";
         this.FTF_JadeNextNme.text = "";
         this.FTF_JadeName.text = "";
         this.FTF_JadeArrt.text = "";
         this.FMC_LeftSlot.Context = null;
         TGameUtil.setButtonMode(this.FMC_TunShi,false);
         TGameUtil.setButtonMode(this.FMC_QiangLiTunShi,false);
         TGameUtil.setButtonMode(this.FMC_Shengxing,true);
         this.FFatherUI["MC_YuUP"].visible = true;
         this.FFatherUI["MC_YuUnlock"].visible = false;
      }
      
      public function ShenJiS_C(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TEquipment = null;
         var _loc9_:int = 0;
         var _loc10_:THero = null;
         _loc9_ = param1.readByte();
         _loc3_ = param1.readUnsignedInt();
         _loc2_ = param1.readUnsignedInt();
         if(_loc9_ == 1)
         {
            if(_loc3_ > 0)
            {
               this.FFlyText(TUtilityString.Format(STRING_JADE.STRING_Nimei1,_loc3_,_loc2_));
            }
            else
            {
               this.FFlyText(TUtilityString.Format(STRING_JADE.STRING_Nimei,_loc2_));
            }
            _loc2_ = param1.readUnsignedInt();
            _loc3_ = param1.readUnsignedInt();
            _loc4_ = param1.readUnsignedInt();
            _loc7_ = param1.readUnsignedInt();
            _loc5_ = param1.readUnsignedInt();
            _loc6_ = param1.readUnsignedInt();
            _loc9_ = param1.readByte();
            if(_loc3_ == 0 && _loc4_ == 0)
            {
               if(_loc7_ == 0)
               {
                  _loc8_ = SLogicsCore.Character.Equipments.GetInventoryByIdentifier(_loc5_,_loc6_) as TEquipment;
                  this.CurInventory = _loc8_.GiftedStoneItems.GetGiftedStoneByIndex(_loc9_) as TInventory;
               }
               else
               {
                  _loc10_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc7_);
                  _loc8_ = _loc10_.EquipmentsMounted.GetInventoryByIdentifier(_loc5_,_loc6_) as TEquipment;
                  this.CurInventory = _loc8_.GiftedStoneItems.GetGiftedStoneByIndex(_loc9_) as TInventory;
               }
            }
            else
            {
               this.CurInventory = SLogicsCore.Character.Gems.GetInventoryByIdentifier(_loc3_,_loc4_);
            }
            this.CurInventory.CurJadeExp = _loc2_;
            this.SelectEquipmentsByTabIndex(this.FRoleIndex,this.FCurrentShowEquipmentBag);
            this.SligeEquipSetValue(true);
            this.UpdateJadeCaiLiao();
            this.UpdateView();
            if(this.FUpdateHeroPower != null && this.FCurHeroId != 0)
            {
               this.FUpdateHeroPower(this,this.FCurHeroId);
            }
            return;
         }
         this.FFlyText(STRING_JADE.STRING_Nimei2);
         this.UpdateJadeCaiLiao();
         this.UpdateView();
      }
      
      protected function SetValueForJade() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         if(this.FCaiLiaoYuClick != null)
         {
            this.FSelectBox.visible = true;
         }
         else
         {
            this.FSelectBox.visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < TenB)
         {
            _loc2_ = this.FCurPageIndex * TenB + _loc1_;
            if(_loc2_ >= this.FCurBagCanXiaoShiJade.Count)
            {
               this.CaiLiaoYuVector[_loc1_].Context = null;
            }
            else
            {
               _loc3_ = this.FCurBagCanXiaoShiJade.GetInventoryByIndex(_loc2_);
               this.CaiLiaoYuVector[_loc1_].Context = _loc3_;
            }
            _loc1_++;
         }
      }
      
      protected function ChangeJade() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         this.FCurBagCanXiaoShiJade.Clear();
         _loc1_ = uint(SLogicsCore.Character.Gems.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = SLogicsCore.Character.Gems.GetInventoryByIndex(_loc2_);
            if(_loc3_ != null)
            {
               if(_loc3_.UpgradingLevel <= this.FShaiXuanLevel && !this.GetBooCaiLiao(_loc3_.IDTemplate))
               {
                  if(this.FJadeTypeComboBoxSelectIndex == 0)
                  {
                     this.FCurBagCanXiaoShiJade.Add(_loc3_);
                  }
                  else if(_loc3_.IDTemplate == 14510001)
                  {
                     this.FCurBagCanXiaoShiJade.Add(_loc3_);
                  }
                  else if(this.FJadeTypeComboBoxSelectIndex == _loc3_.CategorySecond)
                  {
                     this.FCurBagCanXiaoShiJade.Add(_loc3_);
                  }
               }
            }
            _loc2_++;
         }
      }
      
      protected function GetBooCaiLiao(param1:uint) : Boolean
      {
         var _loc2_:TMasterStone = null;
         _loc2_ = SLogicsCore.LostShenQiLogicData.MasterStoneBins.GetDatebaseByIdentifier(param1) as TMasterStone;
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!this.FIsInilization)
         {
            return;
         }
         this.LogicsUpdate();
      }
      
      protected function OnLevelSelect(param1:Object, param2:int) : void
      {
         this.FJadeLevelComboBoxSelectIndex = this.FNameConfig[param2][0];
         this.SelectEquipmentsByTabIndex(this.FRoleIndex,this.FCurrentShowEquipmentBag);
         this.SligeEquipSetValue();
      }
      
      protected function OnTypeSelect(param1:Object, param2:int) : void
      {
         this.FJadeTypeComboBoxSelectIndex = this.FNameConfig2[param2][0];
         this.FCaiLiaoYuClick = null;
         TGameUtil.setButtonMode(this.FMC_TunShi,false);
         TGameUtil.setButtonMode(this.FMC_QiangLiTunShi,false);
         this.UpdateJadeCaiLiao();
      }
      
      protected function ShengJiSlotOnClick(param1:Object, param2:Object) : void
      {
         this.FCaiLiaoYuClick = param2 as TInventory;
         var _loc3_:TUISlot = param1 as TUISlot;
         this.FSelectBox.x = _loc3_.Resource.x - 3;
         this.FSelectBox.y = _loc3_.Resource.y - 3;
         this.FSelectBox.visible = true;
         this.UpdateView();
      }
      
      protected function CurShengJiSlotOnClick(param1:Object, param2:Object) : void
      {
         this.CurSingleEquip.BSelect = false;
         this.CurInventory = null;
         this.CurSingleEquip = null;
         this.SlotsOnOut(param1,param2 as TInventory);
         this.UpdateView();
      }
      
      protected function RoleTabOnSwitch(param1:Object) : void
      {
         this.FRoleIndex = param1 as int;
         this.FRoleIndex += this.FPageIndexHeroList * Ten;
         this.SelectEquipmentsByTabIndex(this.FRoleIndex,this.FCurrentShowEquipmentBag);
         this.SligeEquipSetValue();
      }
      
      private function HeroListPageOnChange(param1:Object, param2:int) : void
      {
         this.FPageIndexHeroList = param2;
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
      }
      
      public function OpenThisPanel() : void
      {
         if(this.CurSingleEquip)
         {
            this.CurSingleEquip.BSelect = false;
            this.CurSingleEquip = null;
         }
         this.CurInventory = null;
         this.FMC_LeftSlot.Context = null;
         this.FPageIndexHeroList = 0;
         this.FRoleIndex = 0;
         this.SetupHeroListPage();
         this.UpdateRoleTab();
         this.FUITab.SwithTagManual(0);
         this.RoleTabOnSwitch(0);
         this.UpdateView();
         this.UpdateJadeCaiLiao();
      }
      
      protected function UpdateJadeCaiLiao() : void
      {
         this.ChangeJade();
         this.SetValueForJade();
         this.UpdateJadePageIdex();
      }
      
      protected function UpdateRoleTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         var _loc3_:uint = 0;
         var _loc4_:THeros = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc4_ = this.FCharacter.Heros;
         _loc4_.Sort();
         _loc6_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < Ten)
         {
            _loc5_ = this.FPageIndexHeroList * Ten + _loc1_;
            if(_loc5_ < _loc6_)
            {
               _loc2_ = _loc4_.GetHeroByIndex(_loc5_);
               _loc3_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc2_.Quality];
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(_loc2_.Name,_loc1_,_loc3_);
            }
            else if(_loc5_ == _loc6_)
            {
               this.FUITab.SetTabShowByIndex(_loc1_);
               this.FUITab.SetTabCaptionByIndex(STRING_COMMON.STRING_Backage,_loc1_,16775109);
            }
            else if(_loc5_ > _loc6_)
            {
               this.FUITab.SetTabHideByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function GetJageList() : TSingelJageList
      {
         var _loc1_:TSingelJageList = null;
         if(this.FList_SingleEquipmentFeiQi.length > 0)
         {
            _loc1_ = this.FList_SingleEquipmentFeiQi.shift();
         }
         if(!_loc1_)
         {
            _loc1_ = new TSingelJageList(this);
         }
         _loc1_.Release();
         return _loc1_;
      }
      
      protected function SligeEquipSetValue(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TSingelJageList = null;
         var _loc5_:TInventory = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc3_ = int(this.FList_SingleEquipment.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FList_SingleEquipment[_loc2_];
            this.FList_SingleEquipmentFeiQi.push(_loc4_);
            _loc2_++;
         }
         this.FList_SingleEquipment.length = 0;
         this.FScrollBar.Clear();
         _loc3_ = this.FCurrentShowEquipmentBag.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.GetJageList();
            _loc5_ = this.FCurrentShowEquipmentBag.GetInventoryByIndex(_loc2_);
            _loc4_.OnClick = this.EquipmentClick;
            _loc4_.OnQuerySequenceContext = TJadeCommon.SlotsOnQuerySequenceContext;
            _loc4_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnOver = this.SlotsOnMove;
            _loc4_.SetEquip(_loc5_,_loc5_.Name);
            this.FScrollBar.AddItem(_loc4_);
            this.FList_SingleEquipment.push(_loc4_);
            if(param1)
            {
               if(this.CurInventory)
               {
                  if(_loc5_ == this.CurInventory)
                  {
                     this.EquipmentClick(_loc4_,_loc5_);
                  }
               }
            }
            _loc7_++;
            _loc2_++;
         }
         if(_loc7_ < CONST_TALISMAN.CAPACITY_EQUIPCopy || _loc7_ == 0)
         {
            _loc3_ = int(CONST_TALISMAN.CAPACITY_EQUIPCopy);
            _loc2_ = 0;
            while(_loc2_ < _loc3_ - _loc7_)
            {
               _loc4_ = this.GetJageList();
               this.FScrollBar.AddItem(_loc4_);
               _loc2_++;
            }
         }
         if(!param1)
         {
            this.FScrollBar.ScrollToUp();
         }
      }
      
      protected function EquipmentClick(param1:Object, param2:Object) : void
      {
         this.CurInventory = param2 as TInventory;
         this.CurSingleEquip = param1 as TSingelJageList;
         this.FMC_LeftSlot.Context = this.CurInventory;
         this.UpdateView();
      }
      
      protected function SelectEquipmentsByTabIndex(param1:int, param2:TInventories) : void
      {
         var _loc3_:THero = null;
         var _loc4_:int = 0;
         var _loc5_:TCollectionInventory = null;
         var _loc6_:TEquipment = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:TAppliance = null;
         _loc8_ = uint(param1);
         this.FCurHeroId = 0;
         if(_loc8_ < SLogicsCore.Character.Heros.Count)
         {
            _loc3_ = SLogicsCore.Character.Heros.GetHeroByIndex(_loc8_);
            _loc5_ = _loc3_.EquipmentsMounted;
            this.FCurHeroId = _loc3_.Identifier;
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc5_.Capacity)
            {
               _loc6_ = _loc5_.GetInventoryByIndex(_loc4_) as TEquipment;
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_.GiftedStoneItems.Count;
                  _loc9_ = 0;
                  while(_loc9_ < _loc7_)
                  {
                     _loc10_ = _loc6_.GiftedStoneItems.GetGiftedStoneByIndex(_loc9_) as TAppliance;
                     if(_loc10_ != null)
                     {
                        if(this.GetBoo(_loc10_))
                        {
                           _loc10_.EquipmentDeJade = _loc6_;
                           param2.Add(_loc10_);
                        }
                     }
                     _loc9_++;
                  }
               }
               _loc4_++;
            }
         }
         else
         {
            _loc7_ = int(SLogicsCore.Character.Equipments.Count);
            param2.Clear();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc6_ = SLogicsCore.Character.Equipments.GetInventoryByIndex(_loc4_) as TEquipment;
               _loc8_ = uint(_loc6_.GiftedStoneItems.Count);
               _loc9_ = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc10_ = _loc6_.GiftedStoneItems.GetGiftedStoneByIndex(_loc9_) as TAppliance;
                  if(_loc10_ != null)
                  {
                     if(this.GetBoo(_loc10_))
                     {
                        _loc10_.EquipmentDeJade = _loc6_;
                        param2.Add(_loc10_);
                     }
                  }
                  _loc9_++;
               }
               _loc4_++;
            }
            _loc7_ = int(SLogicsCore.Character.Gems.Count);
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc10_ = SLogicsCore.Character.Gems.GetInventoryByIndex(_loc4_) as TAppliance;
               if(_loc10_ != null)
               {
                  if(this.GetBoo(_loc10_))
                  {
                     _loc10_.EquipmentDeJade = null;
                     param2.Add(_loc10_);
                  }
               }
               _loc4_++;
            }
         }
      }
      
      protected function GetBoo(param1:TAppliance) : Boolean
      {
         var _loc2_:TMasterStone = null;
         _loc2_ = SLogicsCore.LostShenQiLogicData.MasterStoneBins.GetDatebaseByIdentifier(param1.IDTemplate) as TMasterStone;
         if(_loc2_)
         {
            if(this.FJadeLevelComboBoxSelectIndex == 0)
            {
               return true;
            }
            if(this.FJadeLevelComboBoxSelectIndex == param1.CategorySecond)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function OnSlotClick(param1:Object = null, param2:Object = null) : void
      {
         this.SlotsOnOut(param1,param2 as TInventory);
      }
      
      protected function SlotsOnMoveCopy(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOverCopy != null)
         {
            this.FOnInventoryOverCopy(param2);
         }
      }
      
      protected function SlotsOnOutCopy(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOutCopy != null)
         {
            this.FOnInventoryOutCopy(param2);
         }
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2);
         }
      }
      
      public function set OnInventoryOverCopy(param1:Function) : void
      {
         this.FOnInventoryOverCopy = param1;
      }
      
      public function set OnInventoryOutCopy(param1:Function) : void
      {
         this.FOnInventoryOutCopy = param1;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function set FlyText(param1:Function) : void
      {
         this.FFlyText = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TMasterStone = null;
         _loc4_ = param2 as TInventory;
         param3.Value = "";
      }
      
      protected function SetupHeroListPage() : void
      {
         this.FUIPageHeroList.TotalQuantity = this.FCharacter.Heros.Count + 1;
         this.FUIPageHeroList.Update();
         this.FUIPageHeroList.PageIndex = this.FPageIndexHeroList;
      }
      
      public function LogicsUpdate() : void
      {
         var _loc1_:int = 0;
         if(this.FIsInilization)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FList_SingleEquipment.length)
            {
               this.FList_SingleEquipment[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
            this.FMC_LeftSlot.Update();
            _loc1_ = 0;
            while(_loc1_ < TenB)
            {
               this.CaiLiaoYuVector[_loc1_].Update();
               _loc1_++;
            }
         }
      }
      
      protected function UpdateCaiLiaoYuVector() : void
      {
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_JADE.RESOURCE_ClassName_ComboBoxItem2) as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
   }
}

