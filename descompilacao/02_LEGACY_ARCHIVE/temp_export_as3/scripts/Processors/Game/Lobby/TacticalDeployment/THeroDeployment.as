package Processors.Game.Lobby.TacticalDeployment
{
   import Components.ComboBox.TComboBox;
   import Foundation.Common.TCoordinate;
   import Foundation.Network.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.*;
   
   public class THeroDeployment extends TUIComponent
   {
      
      protected static const TYPE_NORMAL:int = 1;
      
      protected static const TYPE_LIGHT:int = 2;
      
      protected static const TYPE_DISABLED:int = 3;
      
      protected static const MAX_COUNT:int = 15;
      
      protected static const INDEX_STAMP:int = 5;
      
      protected static const DEPLOYMENT_WIDTH:Number = 117;
      
      protected static const DEPLOYMENT_HEIGHT:Number = 37;
      
      protected static const CONST_ACTIVE_CLASSNAME:String = "hero";
      
      protected static const LimitValue:uint = 4;
      
      protected var FScene:MovieClip;
      
      protected var FMC_ComboBox:TComboBox;
      
      protected var FBTN_Change:MovieClip;
      
      protected var FBTN_Backup:MovieClip;
      
      protected var FMaxPlay:int;
      
      protected var FHeroDeployment:THeros;
      
      protected var FSelectHero:THero;
      
      protected var FTipCountTF:TextField;
      
      protected var FNormalFormat:TextFormat;
      
      protected var FOverFormat:TextFormat;
      
      protected var FShowHeadIndex:int;
      
      protected var FMouseInIndex:uint;
      
      protected var FShowList:Vector.<DisplayObject>;
      
      protected var FSystemLanguageBins:TBins;
      
      protected var FAutoChangeFormData:Vector.<TAutoChangeFormInfo>;
      
      protected var FDragEnable:Boolean = true;
      
      protected var FSelectIndex:int;
      
      protected var FOnEffectText:Function;
      
      protected var FSetSelectHero:Function;
      
      protected var FSetSelectHeroBitmapVisible:Function;
      
      protected var FOnEnterMilitary:Function;
      
      protected var FResetDeployment:Function;
      
      protected var FDragEnableCallBack:Function;
      
      protected var FAutoChangeForm:Function;
      
      public function THeroDeployment(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function InitDeployment() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = this.FScene["mc_pos_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc2_.mc_index.visible = false;
               _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.OnSelectHero);
               _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnShowHero);
               _loc2_.buttonMode = true;
            }
            _loc1_++;
         }
         this.FNormalFormat = new TextFormat();
         this.FNormalFormat.underline = true;
         this.FNormalFormat.color = 65280;
         this.FOverFormat = new TextFormat();
         this.FOverFormat.underline = true;
         this.FOverFormat.color = 16711680;
         this.FScene.mc_tipCount.buttonMode = true;
         this.FScene.mc_tipCount.addEventListener(MouseEvent.ROLL_OVER,this.OnTextRoll);
         this.FScene.mc_tipCount.addEventListener(MouseEvent.ROLL_OUT,this.OnTextRoll);
         this.FScene.mc_tipCount.addEventListener(MouseEvent.CLICK,this.OnTextClicked);
         this.FTipCountTF = this.FScene.mc_tipCount.tf_tipCount;
         this.FTipCountTF.text = "";
         this.FTipCountTF.selectable = false;
         this.FTipCountTF.mouseEnabled = false;
         this.FScene.addEventListener(MouseEvent.MOUSE_UP,this.OnChangeHero);
         this.FSystemLanguageBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         this.FMC_ComboBox = new TComboBox(this,this.FScene.MC_ComboBox,null,50,this.SelectCallBack);
         this.FBTN_Change = this.FScene.MC_Change_Btn;
         TGameUtil.setButtonMode(this.FBTN_Change,true);
         this.FBTN_Change.addEventListener(MouseEvent.CLICK,this.onChangeBtnHandler);
         this.FBTN_Backup = this.FScene.MC_Backup_Btn;
         TGameUtil.setButtonMode(this.FBTN_Backup,true);
         this.FBTN_Backup.addEventListener(MouseEvent.CLICK,this.onBackupHandler);
      }
      
      protected function ShowLightWithIndex(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            if(int(_loc2_ / INDEX_STAMP) + 1 == param1)
            {
               _loc3_ = this.FScene["mc_pos_" + _loc2_];
               if(_loc3_ != null)
               {
                  _loc3_.gotoAndStop(TYPE_LIGHT);
               }
            }
            _loc2_++;
         }
      }
      
      protected function ShowNormal() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TActive = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = this.FScene["mc_pos_" + _loc1_];
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.getChildByName(CONST_ACTIVE_CLASSNAME) as TActive;
               if(_loc3_ == null)
               {
                  _loc2_.gotoAndStop(TYPE_NORMAL);
               }
               else
               {
                  _loc2_.gotoAndStop(TYPE_LIGHT);
               }
            }
            _loc1_++;
         }
      }
      
      protected function ShowDisabledWithIndex(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            if(int(_loc2_ / INDEX_STAMP) + 1 != param1)
            {
               _loc3_ = this.FScene["mc_pos_" + _loc2_];
               if(_loc3_ != null)
               {
                  _loc3_.gotoAndStop(TYPE_DISABLED);
               }
            }
            _loc2_++;
         }
      }
      
      protected function CheckPlayCount() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         this.FScene.tf_fightCount.text = this.FHeroDeployment.Count + "/" + this.FMaxPlay;
         _loc2_ = uint(CONST_SYSTEMLANGUAGE["TACTICALDEPLOYMENT_STRING_0" + (this.FMaxPlay + LimitValue)]);
         _loc1_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(_loc2_) as TSystemLanguage;
         this.FTipCountTF.text = _loc1_.Desc;
         this.FTipCountTF.setTextFormat(this.FNormalFormat);
      }
      
      protected function GetHeroByPos(param1:int) : THero
      {
         var _loc2_:uint = 0;
         var _loc3_:THero = null;
         _loc2_ = 0;
         while(_loc2_ < this.FHeroDeployment.Count)
         {
            _loc3_ = this.FHeroDeployment.GetHeroByIndex(_loc2_);
            if(_loc3_.FightPosition == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function CheckInDeployment() : int
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         _loc1_ = this.FScene.mouseX;
         _loc2_ = this.FScene.mouseY;
         if(_loc1_ >= this.FScene.mc_pos_1.x && _loc1_ <= this.FScene.mc_pos_1.x + DEPLOYMENT_WIDTH && _loc2_ >= this.FScene.mc_pos_1.y && _loc2_ <= this.FScene.mc_pos_1.y + DEPLOYMENT_HEIGHT)
         {
            return 1;
         }
         if(_loc1_ >= this.FScene.mc_pos_6.x && _loc1_ <= this.FScene.mc_pos_6.x + DEPLOYMENT_WIDTH && _loc2_ >= this.FScene.mc_pos_6.y && _loc2_ <= this.FScene.mc_pos_6.y + DEPLOYMENT_HEIGHT)
         {
            return 6;
         }
         if(_loc1_ >= this.FScene.mc_pos_7.x && _loc1_ <= this.FScene.mc_pos_7.x + DEPLOYMENT_WIDTH && _loc2_ >= this.FScene.mc_pos_7.y && _loc2_ <= this.FScene.mc_pos_7.y + DEPLOYMENT_HEIGHT)
         {
            return 7;
         }
         if(_loc1_ >= this.FScene.mc_pos_8.x && _loc1_ <= this.FScene.mc_pos_8.x + DEPLOYMENT_WIDTH && _loc2_ >= this.FScene.mc_pos_8.y && _loc2_ <= this.FScene.mc_pos_8.y + DEPLOYMENT_HEIGHT)
         {
            return 8;
         }
         if(_loc1_ >= this.FScene.mc_pos_11.x && _loc1_ <= this.FScene.mc_pos_11.x + DEPLOYMENT_WIDTH && _loc2_ >= this.FScene.mc_pos_11.y && _loc2_ <= this.FScene.mc_pos_11.y + DEPLOYMENT_HEIGHT)
         {
            return 11;
         }
         if(_loc1_ >= this.FScene.mc_pos_12.x && _loc1_ <= this.FScene.mc_pos_12.x + DEPLOYMENT_WIDTH && _loc2_ >= this.FScene.mc_pos_12.y && _loc2_ <= this.FScene.mc_pos_12.y + DEPLOYMENT_HEIGHT)
         {
            return 12;
         }
         if(_loc1_ >= this.FScene.mc_pos_13.x && _loc1_ <= this.FScene.mc_pos_13.x + DEPLOYMENT_WIDTH && _loc2_ >= this.FScene.mc_pos_13.y && _loc2_ <= this.FScene.mc_pos_13.y + DEPLOYMENT_HEIGHT)
         {
            return 13;
         }
         return 0;
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("MC_FamilyList") as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function SelectCallBack(param1:Object, param2:uint) : void
      {
         this.FSelectIndex = param2;
         this.FDragEnable = param2 == 0 ? true : false;
         this.FDragEnableCallBack(this.FDragEnable);
         if(param2 == 0)
         {
            this.FResetDeployment();
            return;
         }
         this.SetDeploymentData(this.FMaxPlay,this.GetDeploymentHeroInfo(this.FMC_ComboBox.CurSelectBtn.tf_into.text.substr(-1,1)));
      }
      
      protected function GetDeploymentHeroInfo(param1:int) : THeros
      {
         var _loc2_:THeros = null;
         var _loc3_:THero = null;
         var _loc4_:TAutoChangeFormInfo = null;
         var _loc5_:TAutoChangeFormHeroInfo = null;
         _loc2_ = new THeros();
         for each(_loc4_ in this.FAutoChangeFormData)
         {
            if(param1 == _loc4_.FormId)
            {
               for each(_loc5_ in _loc4_.HeroInfo)
               {
                  _loc3_ = new THero(_loc5_.heroId);
                  _loc3_.FightPosition = _loc5_.Fightpos;
                  _loc2_.Add(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      protected function OnTextRoll(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.FTipCountTF.setTextFormat(this.FOverFormat);
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            this.FTipCountTF.setTextFormat(this.FNormalFormat);
         }
      }
      
      protected function OnTextClicked(param1:MouseEvent) : void
      {
         if(this.FOnEnterMilitary != null)
         {
            this.FOnEnterMilitary(this);
         }
      }
      
      protected function OnChangeHero(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:Boolean = false;
         var _loc6_:TSystemLanguage = null;
         var _loc7_:String = null;
         if(this.FSelectHero == null)
         {
            return;
         }
         _loc5_ = false;
         _loc2_ = this.CheckInDeployment();
         if(this.FSelectHero.StandPositionWithProfession != int(_loc2_ / INDEX_STAMP) + 1)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > 0)
         {
            if(this.FSelectHero != null && this.FSelectHero.FightPosition != _loc2_)
            {
               if(this.FSelectHero.FightPosition <= 0 && this.FMaxPlay <= this.FHeroDeployment.Count && this.GetHeroByPos(_loc2_) == null)
               {
                  _loc6_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_05) as TSystemLanguage;
                  _loc7_ = _loc6_.Desc;
               }
               else
               {
                  _loc5_ = true;
               }
            }
         }
         else if(this.FSelectHero.IsMain)
         {
            _loc6_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_02) as TSystemLanguage;
            _loc7_ = _loc6_.Desc;
         }
         else
         {
            _loc5_ = true;
         }
         if(_loc5_)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TacticalDeployment_ChangePositionReq);
            _loc4_ = _loc3_.Data;
            _loc4_.writeUnsignedInt(this.FSelectHero.Identifier);
            _loc4_.writeByte(_loc2_);
            SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         }
         else if(_loc7_ != null && _loc7_.length > 0 && this.FOnEffectText != null)
         {
            this.FOnEffectText(_loc7_);
         }
      }
      
      protected function OnSelectHero(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:TSystemLanguage = null;
         var _loc5_:String = null;
         if(!this.FDragEnable)
         {
            _loc4_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_11) as TSystemLanguage;
            _loc5_ = _loc4_.Desc;
            this.FOnEffectText(_loc5_);
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         _loc3_ = this.GetHeroByPos(_loc2_);
         this.SetListSelectHero(_loc3_);
         if(this.FSetSelectHero != null)
         {
            this.FSetSelectHero(_loc3_);
         }
      }
      
      protected function OnShowHero(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TActive = null;
         if(this.FSelectHero == null)
         {
            return;
         }
         _loc2_ = uint(this.CheckInDeployment());
         if(_loc2_ <= 0)
         {
            _loc3_ = this.FScene["mc_pos_" + this.FMouseInIndex];
            if(_loc3_ != null)
            {
               if(this.FSelectHero.StandPositionWithProfession == int(this.FMouseInIndex / INDEX_STAMP) + 1)
               {
                  _loc4_ = _loc3_.getChildByName(CONST_ACTIVE_CLASSNAME) as TActive;
                  if(_loc4_ == null)
                  {
                     if(_loc3_.currentFrame != TYPE_NORMAL)
                     {
                        _loc3_.gotoAndStop(TYPE_NORMAL);
                     }
                  }
               }
            }
            return;
         }
         _loc3_ = this.FScene["mc_pos_" + _loc2_];
         this.FMouseInIndex = _loc2_;
         if(_loc3_ != null)
         {
            if(this.FSelectHero.StandPositionWithProfession == int(_loc2_ / INDEX_STAMP) + 1)
            {
               if(_loc3_.currentFrame != TYPE_LIGHT)
               {
                  _loc3_.gotoAndStop(TYPE_LIGHT);
               }
            }
         }
      }
      
      protected function onBackupHandler(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         var _loc3_:String = null;
         if(this.FSelectIndex == 0)
         {
            _loc2_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_11) as TSystemLanguage;
            _loc3_ = _loc2_.Desc;
            this.FOnEffectText(_loc3_);
         }
         if(this.FSelectIndex > 0)
         {
            this.FAutoChangeForm(4,this.FMC_ComboBox.CurSelectBtn.tf_into.text.substr(-1,1));
            _loc2_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_12) as TSystemLanguage;
            _loc3_ = _loc2_.Desc;
            this.FOnEffectText(_loc3_);
         }
      }
      
      protected function onChangeBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         var _loc3_:String = null;
         if(this.FSelectIndex > 0)
         {
            this.FAutoChangeForm(1,this.FMC_ComboBox.CurSelectBtn.tf_into.text.substr(-1,1));
         }
         else
         {
            _loc2_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_15) as TSystemLanguage;
            _loc3_ = _loc2_.Desc;
            this.FOnEffectText(_loc3_);
         }
      }
      
      public function get SetSelectHero() : Function
      {
         return this.FSetSelectHero;
      }
      
      public function set SetSelectHero(param1:Function) : void
      {
         this.FSetSelectHero = param1;
      }
      
      public function get SetSelectHeroBitmapVisible() : Function
      {
         return this.FSetSelectHeroBitmapVisible;
      }
      
      public function set SetSelectHeroBitmapVisible(param1:Function) : void
      {
         this.FSetSelectHeroBitmapVisible = param1;
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function get OnEnterMilitary() : Function
      {
         return this.FOnEnterMilitary;
      }
      
      public function set OnEnterMilitary(param1:Function) : void
      {
         this.FOnEnterMilitary = param1;
      }
      
      public function set AutoChangeForm(param1:Function) : void
      {
         this.FAutoChangeForm = param1;
      }
      
      public function set ResetDeployment(param1:Function) : void
      {
         this.FResetDeployment = param1;
      }
      
      public function set DragEnableCallBack(param1:Function) : void
      {
         this.FDragEnableCallBack = param1;
      }
      
      public function GetCheckFrame() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc2_ = 2;
         if(this.FSelectHero == null)
         {
            _loc2_ = 2;
         }
         _loc1_ = uint(this.CheckInDeployment());
         if(_loc1_ > 0 && this.FSelectHero.StandPositionWithProfession == int(_loc1_ / INDEX_STAMP) + 1)
         {
            _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FScene = param1;
         this.InitDeployment();
      }
      
      public function SetDeploymentData(param1:int, param2:THeros) : void
      {
         this.FMaxPlay = param1;
         this.FHeroDeployment = param2;
         this.FHeroDeployment.SortByHeroSpeed();
         this.SetUI();
         this.CheckPlayCount();
      }
      
      public function SetFormData(param1:Vector.<TAutoChangeFormInfo>) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:TSystemLanguage = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:TAutoChangeFormInfo = null;
         var _loc2_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         _loc5_ = (this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_14) as TSystemLanguage).Desc;
         _loc6_ = (this.FSystemLanguageBins.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_13) as TSystemLanguage).Desc;
         this.FAutoChangeFormData = param1;
         for each(_loc7_ in this.FAutoChangeFormData)
         {
            _loc3_ = this.MakeComboItem(_loc5_ + _loc7_.FormId);
            _loc2_.push(_loc3_);
         }
         _loc3_ = this.MakeComboItem(_loc6_);
         _loc2_.unshift(_loc3_);
         this.FMC_ComboBox.ResetList(_loc2_);
         this.SelectCallBack(this,this.FSelectIndex);
      }
      
      public function SetListSelectHero(param1:THero = null) : void
      {
         this.FSelectHero = param1;
         if(param1 != null)
         {
            this.ShowDisabledWithIndex(param1.StandPositionWithProfession);
         }
         else
         {
            this.ShowNormal();
         }
      }
      
      public function SetUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TActive = null;
         if(this.FHeroDeployment == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc4_ = this.FScene["mc_pos_" + _loc1_];
            if(_loc4_ != null)
            {
               _loc4_.mc_index.visible = false;
               if(_loc4_.currentFrame != TYPE_NORMAL)
               {
                  _loc4_.gotoAndStop(TYPE_NORMAL);
               }
               _loc5_ = _loc4_.getChildByName(CONST_ACTIVE_CLASSNAME) as TActive;
               if(_loc5_ != null)
               {
                  TPoolRole.SaveActive(_loc5_);
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FHeroDeployment.Count)
         {
            _loc2_ = this.FHeroDeployment.GetHeroByIndex(_loc1_);
            _loc3_ = _loc2_.FightPosition;
            _loc4_ = this.FScene["mc_pos_" + _loc3_];
            if(_loc4_ != null)
            {
               _loc4_.mc_index.visible = true;
               _loc4_.mc_index.tf_index.text = String(_loc1_ + 1);
               if(_loc4_.currentFrame != TYPE_LIGHT)
               {
                  _loc4_.gotoAndStop(TYPE_LIGHT);
               }
               _loc5_ = TPoolRole.GetActive(null,_loc2_.Identifier,CONST_MODULES.MODULE_TacticalDeployment,true);
               _loc5_.name = CONST_ACTIVE_CLASSNAME;
               _loc4_.addChild(_loc5_);
               _loc5_.x = 50;
               _loc5_.y = 18;
            }
            _loc1_++;
         }
      }
      
      public function UpdataUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THero = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TActive = null;
         if(this.FHeroDeployment == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FHeroDeployment.Count)
         {
            _loc2_ = this.FHeroDeployment.GetHeroByIndex(_loc1_);
            _loc3_ = _loc2_.FightPosition;
            _loc4_ = this.FScene["mc_pos_" + _loc3_];
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.getChildByName(CONST_ACTIVE_CLASSNAME) as TActive;
               if(_loc5_ != null)
               {
                  _loc5_.UpdateActive();
               }
            }
            _loc1_++;
         }
      }
      
      public function GetPosPoint(param1:uint) : TCoordinate
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TCoordinate = null;
         _loc3_ = this.FScene["mc_pos_" + param1];
         if(_loc3_ != null)
         {
            _loc4_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc3_);
         }
         return _loc4_;
      }
   }
}

